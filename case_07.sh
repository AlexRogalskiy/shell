#!/bin/bash

if read -t 10 -sp "ENTER secret passphrase > " secret_passphrase; then
	echo -e "\nSecret passphrase = '$secret_passphrase"
else
	echo -e "\nInput is timeod out" >&2
	exit 1
fi