#!/bin/bash
set -ex

build="go run -mod=vendor build.go --enable-cgo"

# Build binary
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
    ${build}
else
    # We are cross-compiling a program with a build script written in go
    # if we set $GOOS and $GOARCH, this will not work as we are not on the
    # target platform.  Fortunately, restic's build script does support this
    # as an option:
    _goos=${GOOS}
    _goarch=${GOARCH}
    unset GOOS GOARCH
    ${build} --goos ${_goos} --goarch ${_goarch}
fi

# Install binary
mkdir -p $PREFIX/bin
mv restic $PREFIX/bin/restic

# Setup and copy licenses of dependencies
go install github.com/google/go-licenses@latest
go-licenses save github.com/restic/restic/cmd/restic --save_path=licenses
mkdir -p $PREFIX/info
mv licenses $PREFIX/info/
