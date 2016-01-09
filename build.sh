#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))
export GOPATH=$DIR

go get -d -u github.com/satori/go.uuid
go get -d -u golang.org/x/crypto/openpgp
go get -d -u gopkg.in/qml.v1
go install -v -x password-shroud
cp bin/password-shroud $DIR
