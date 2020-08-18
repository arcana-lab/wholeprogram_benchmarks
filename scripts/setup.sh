mkdir -p install
temp=${GOPATH}
export GOPATH=`pwd`/install
go get github.com/SRI-CSL/gllvm/cmd/...
export GOPATH=${temp}
