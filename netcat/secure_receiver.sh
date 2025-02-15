#!/bin/bash

echo "Waiting for messages..."

while true; do
  # Receive and decrypt messages
  nc -l 12345 | openssl enc -aes-256-cbc -d -salt -base64 \
    -pbkdf2 -pass pass:chatpassword 2>/dev/null
done