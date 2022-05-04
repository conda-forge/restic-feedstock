rem Building binary
go mod vendor
go run -mod=vendor build.go --enable-cgo

rem Install binary
mkdir -p %PREFIX%\bin
cp restic.exe %PREFIX%\bin\restic.exe

rem Setup and copy licenses of dependencies
set GOBIN=%PREFIX%\bin
go install github.com/google/go-licenses@latest
%PREFIX%\bin\go-licenses save github.com/restic/restic/cmd/restic --save_path=licenses
del %PREFIX%\bin\go-licenses.exe
