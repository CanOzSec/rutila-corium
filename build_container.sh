#!/bin/bash

# Build the container
docker build -t "rutila-corium" .

# Create the configurations
mkdir -p "$HOME/.local/rutila-corium/config/certs"
cp config/krb5.conf "$HOME/.local/rutila-corium/config/"
cp config/Responder.conf "$HOME/.local/rutila-corium/config/"
cp config/environment.conf "$HOME/.local/rutila-corium/config/"
cp config/proxychains4.conf "$HOME/.local/rutila-corium/config/"
openssl genrsa -out "$HOME/.local/rutila-corium/config/certs/responder.key" 2048
openssl req -new -x509 -days 3650 -key "$HOME/.local/rutila-corium/config/certs/responder.key" -out "$HOME/.local/rutila-corium/config/certs/responder.crt" -subj "/"
