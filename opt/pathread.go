package main

import (
    "fmt"
    "log"
    "os"
    "path/filepath"
    "sort"
    "strings"
)

// 実行可能ファイルの判定
func isExecutable(fi os.FileInfo) bool {
    if fi.IsDir() {
        return false
    }
    ext := strings.ToLower(filepath.Ext(fi.Name()))
    switch ext {
    case ".exe", ".bat", ".cmd", ".com":
        return true
    }
    // UNIX系の実行属性
    mode := fi.Mode()
    return mode.IsRegular() && (mode&0111 != 0)
}

func main() {
    optDir := os.Getenv("OPT")
    if optDir == "" {
        log.Fatalf("環境変数OPTが設定されていません")
    }
    optDirAbs, err := filepath.Abs(optDir)
    if err != nil {
        log.Fatalf("OPT絶対パス取得失敗: %v", err)
    }
    optDirAbs = filepath.ToSlash(optDirAbs)

    dirSet := make(map[string]struct{})

    err = filepath.WalkDir(optDirAbs, func(path string, d os.DirEntry, err error) error {
        if err != nil {
            return err
        }
        if d.IsDir() {
            return nil
        }
        fi, err := d.Info()
        if err != nil {
            return nil
        }
        if isExecutable(fi) {
            dir := filepath.Dir(path)
            dir = filepath.ToSlash(dir)
            rel, err := filepath.Rel(optDirAbs, dir)
            if err != nil {
                return nil
            }
            rel = filepath.ToSlash(rel)
            var pathEnv string
            if rel == "." || rel == "" {
                pathEnv = "$OPT"
            } else {
                pathEnv = "$OPT/" + rel
            }
            dirSet[pathEnv] = struct{}{}
        }
        return nil
    })
    if err != nil {
        log.Fatalf("ディレクトリ走査失敗: %v", err)
    }

    // アルファベット順で出力
    var dirs []string
    for dir := range dirSet {
        dirs = append(dirs, dir)
    }
    sort.Strings(dirs)

    var builder strings.Builder
    for _, dir := range dirs {
        builder.WriteString(fmt.Sprintf("export PATH=\"$PATH:%s\"\n", dir))
    }

    outputPath := filepath.Join(optDirAbs, ".paths")
    err = os.WriteFile(outputPath, []byte(builder.String()), 0644)
    if err != nil {
        log.Fatalf(".paths ファイル書き込み失敗: %v", err)
    }

    // fmt.Printf(".paths ファイルを %s に出力しました\n", outputPath)
}
