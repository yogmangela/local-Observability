#!/bin/bash

# Set up color codes for better visibility
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Secure Chat Receiver - Started at $(date)${NC}"
echo -e "${BLUE}Waiting for messages... Press Ctrl+C to exit${NC}"
echo "----------------------------------------"

while true; do
    # Receive and show the encrypted message
    echo -e "${BLUE}Waiting for next message...${NC}"

    encrypted=$(nc -l 12345)

    # Skip if received nothing
    if [ -z "$encrypted" ]; then
        continue
    fi

    echo -e "${YELLOW}Received encrypted message:${NC} ${encrypted:0:50}..." # Show first 50 chars
    echo -e "${BLUE}Decrypting...${NC}"

    # Decrypt and display the message
    decrypted=$(echo "$encrypted" | openssl enc -aes-256-cbc -d -salt -base64 \
        -pbkdf2 -iter 10000 -pass pass:chatpassword 2>/dev/null)

    # Check if decryption was successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Decrypted message:${NC} $decrypted"
    else
        echo -e "\033[0;31mError: Failed to decrypt message${NC}"
    fi

    echo "----------------------------------------"
done