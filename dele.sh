# run on unzip root(/)
git clone https://github.com/Mokkori-Tom/minish
rm -rf autorebase.bat clang64.ico clangarm64.exe mingw32 mingw32.ini mingw64.ico msys2.exe msys2_shell.cmd ucrt64 ucrt64.ini clang64 clang64.ini clangarm64.ico mingw32.exe mingw64 mingw64.ini msys2.ico ucrt64.exe clang64.exe clangarm64 clangarm64.ini mingw32.ico mingw64.exe msys2.ini ucrt64.ico
mv minish/* ./
go build -o minish.exe minish.go
go build -o opt/pathread.exe opt/pathread.go
go build -o opt/dlzip/dlzip.exe opt/dlzip/dlzip.go
go build -o opt/insert/insert.exe opt/insert/insert.go
go build -o opt/rgd/rgd.exe opt/rgd/rgd.go
start ./minish
