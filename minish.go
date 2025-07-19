package main

import (
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

func must(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
	exePath, err := os.Executable()
	must(err)
	root := filepath.Dir(exePath)

	bash := filepath.Join(root, "usr", "bin", "bash.exe")
	if runtime.GOOS != "windows" {
		bash = filepath.Join(root, "usr", "bin", "bash")
	}
	initScript := filepath.Join(root, "init.sh")

	// chdirは無し（カレント維持）

	cmd := exec.Command(bash, initScript)
	cmd.Args = append(cmd.Args, os.Args[1:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	must(cmd.Run())
}
