#!/bin/bash

echo "Secure Chat - Type your messages below"
echo "Press Ctrl+C to exit"

while true; do
  # Get the message
  read message

  # Encrypt and send it
  echo "$message" | openssl enc -aes-256-cbc -salt -base64 \
    -pbkdf2 -pass pass:chatpassword 2>/dev/null | \
    nc -N localhost 12345
done