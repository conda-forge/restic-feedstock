rem Building binary
go run -mod=vendor build.go --enable-cgo

rem Install binary
mkdir -p %PREFIX%\bin
mv restic.exe %PREFIX%\bin\restic.exe
