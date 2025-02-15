#!/bin/bash

# Set up color codes for better visibility
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}Secure Chat Sender - Started at $(date)${NC}"
echo -e "${BLUE}Type your messages below. Press Ctrl+C to exit${NC}"
echo "----------------------------------------"

while true; do
    # Show prompt with timestamp
    echo -ne "${GREEN}[$(date +%H:%M:%S)]${NC} Your message: "

    # Get the message
    read message

    # Skip if message is empty
    if [ -z "$message" ]; then
        continue
    fi

    # Add timestamp to message
    timestamped_message="[$(date +%H:%M:%S)] $message"

    # Show encryption status
    echo -e "${BLUE}Encrypting and sending message...${NC}"

    # Encrypt and send it, showing the encrypted form
    encrypted=$(echo "$timestamped_message" | openssl enc -aes-256-cbc -salt -base64 \
        -pbkdf2 -iter 10000 -pass pass:chatpassword 2>/dev/null)

    echo -e "${BLUE}Encrypted form:${NC} ${encrypted:0:50}..." # Show first 50 chars
    echo "$encrypted" | nc localhost 12345

    echo -e "${GREEN}Message sent successfully!${NC}"
    echo "----------------------------------------"
done