#!/usr/bin/env bash

openssl req \
    -newkey rsa:2048 \
    -x509 \
    -nodes \
    -keyout ../localtest.key \
    -new \
    -out ../localtest.crt \
    -config ./openssl-custom.cnf \
    -sha256 \
    -days 3652