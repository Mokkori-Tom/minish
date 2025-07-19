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

// 使用する7z系コマンドの候補
var sevenZipCmds = []string{"7zr", "7za", "7z"}

func main() {
	if len(os.Args) < 3 {
		fmt.Println("使い方: go run main.go <ダウンロードURL> <展開先ディレクトリ>")
		os.Exit(1)
	}

	// zstdコマンド存在チェック
	if _, err := exec.LookPath("zstd"); err != nil {
		fmt.Fprintln(os.Stderr, "エラー: zstdコマンドが見つかりません。")
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
	defer resp.Body.Close()
	out, err := os.Create(archivePath)
	if err != nil {
		fmt.Fprintln(os.Stderr, "一時ファイル作成エラー:", err)
		os.Exit(1)
	}
	_, err = io.Copy(out, resp.Body)
	out.Close()
	if err != nil {
		fmt.Fprintln(os.Stderr, "保存エラー:", err)
		os.Exit(1)
	}
	fmt.Println("Downloaded.")

	// 2. 展開処理
	if strings.HasSuffix(fileName, ".zst") {
		tarPath := archivePath[:len(archivePath)-4]
		fmt.Println("Decompressing zst to tar...")
		if err := decompressZst(archivePath, tarPath); err != nil {
			fmt.Fprintln(os.Stderr, "zstd展開エラー:", err)
			os.Remove(archivePath)
			os.Exit(1)
		}
		fmt.Println("Extracting tar with 7z family...")
		if err := extractWithAny7z(tarPath, destDir); err != nil {
			fmt.Fprintln(os.Stderr, "7z展開エラー:", err)
			os.Remove(archivePath)
			os.Remove(tarPath)
			os.Exit(1)
		}
		os.Remove(tarPath)
	} else {
		fmt.Println("Extracting archive with 7z family...")
		if err := extractWithAny7z(archivePath, destDir); err != nil {
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

// 7zr, 7za, 7z すべて順に試し、どれか成功したらOK
func extractWithAny7z(src, dest string) error {
	for _, cmdName := range sevenZipCmds {
		if _, err := exec.LookPath(cmdName); err != nil {
			continue
		}
		cmd := exec.Command(cmdName, "x", "-y", "-o"+dest, src)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		fmt.Printf("Trying: %s ...\n", cmdName)
		if err := cmd.Run(); err == nil {
			fmt.Printf("Success: %s\n", cmdName)
			return nil
		}
	}
	return fmt.Errorf("7z系コマンド全て失敗")
}
