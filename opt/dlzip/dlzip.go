package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func main() {
	if len(os.Args) < 3 {
		fmt.Println("使い方: go run main.go <ダウンロードURL> <展開先ディレクトリ>")
		os.Exit(1)
	}

	// 7z・zstdコマンドの有無を確認
	if _, err := exec.LookPath("7z"); err != nil {
		fmt.Fprintln(os.Stderr, "エラー: 7zコマンドが見つかりません。")
		fmt.Fprintln(os.Stderr, "7-Zip（7z）をインストールし、パスが通っているか確認してください。")
		os.Exit(1)
	}
	if _, err := exec.LookPath("zstd"); err != nil {
		fmt.Fprintln(os.Stderr, "エラー: zstdコマンドが見つかりません。")
		fmt.Fprintln(os.Stderr, "Zstandardコマンド（zstd）をインストールし、パスが通っているか確認してください。")
		os.Exit(1)
	}

	url := os.Args[1]
	destDir := os.Args[2]
	fileName := filepath.Base(url)
	archivePath := filepath.Join(os.TempDir(), fileName)

	// 1. ダウンロード
	fmt.Println("Downloading:", url)
	resp, err := http.Get(url)
	if err != nil {
		fmt.Fprintln(os.Stderr, "ダウンロードエラー:", err)
		os.Exit(1)
	}
	out, err := os.Create(archivePath)
	if err != nil {
		fmt.Fprintln(os.Stderr, "一時ファイル作成エラー:", err)
		os.Exit(1)
	}
	_, err = io.Copy(out, resp.Body)
	if err != nil {
		fmt.Fprintln(os.Stderr, "保存エラー:", err)
		out.Close()
		os.Exit(1)
	}
	out.Close() // ここで明示的にクローズ！
	fmt.Println("Downloaded.")

	// 2. 展開処理
	if strings.HasSuffix(fileName, ".zst") {
		// .zstファイルの場合
		tarPath := archivePath[:len(archivePath)-4] // .zstを除いた.tarパス
		fmt.Println("Decompressing zst to tar...")
		if err := decompressZst(archivePath, tarPath); err != nil {
			fmt.Fprintln(os.Stderr, "zstd展開エラー:", err)
			os.Remove(archivePath)
			os.Exit(1)
		}
		fmt.Println("Extracting tar with 7z...")
		if err := extractWith7z(tarPath, destDir); err != nil {
			fmt.Fprintln(os.Stderr, "7z展開エラー:", err)
			os.Remove(archivePath)
			os.Remove(tarPath)
			os.Exit(1)
		}
		os.Remove(tarPath)
	} else {
		// それ以外は7z一発
		fmt.Println("Extracting archive with 7z...")
		if err := extractWith7z(archivePath, destDir); err != nil {
			fmt.Fprintln(os.Stderr, "7z展開エラー:", err)
			os.Remove(archivePath)
			os.Exit(1)
		}
	}
	os.Remove(archivePath)
	fmt.Println("Done.")
}

func decompressZst(src, dst string) error {
	cmd := exec.Command("zstd", "-d", "-f", src, "-o", dst)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func extractWith7z(src, dest string) error {
	cmd := exec.Command("7z", "x", "-y", "-o"+dest, src)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}
