#!/bin/bash

export GOPATH=/opt/repositories/go


function error_handling() {
    ret=$?
    if [ $ret -ne 0 ]; then
        echo "[!] An error occurred when $1"
        exit 127
    else
        echo -e "[*] $2    OK"
    fi
}
