#!/bin/bash

# Ensure the script is using Bash.
if [[ ! "$BASH_VERSION" ]]; then
    echo "This script requires Bash. Run it with: bash $0"
    exit 1
fi

# Function to print prominent headers
print_header() {
    echo "==============================================="
    echo "              $1"
    echo "==============================================="
}

# Check if a command exists
check_tool() {
    if ! command -v "$1" &>/dev/null; then
        echo "Error: $1 is not installed. Please install it and try again."
        exit 1
    fi
}

# Validate domain function
validate_domain() {
    if [[ ! $1 =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Error: Invalid domain format. Please enter a valid domain (e.g., google.com)."
        exit 1
    fi
}

# Prompt for domain input
read -p "Enter your domain (e.g., google.com): " domain
validate_domain "$domain"

# Check for necessary tools
tools=(subfinder httpx gau katana uro Gxss dalfox)
for tool in "${tools[@]}"; do
    check_tool "$tool"
done

# Start processing
mkdir -p "$domain"

print_header "Your domain is $domain"
print_header "Starting subdomain enumeration"
subfinder -d "$domain" >"$domain/subdomains.txt"

print_header "Collecting live hosts"
httpx -l "$domain/subdomains.txt" -o "$domain/live_subdomains.txt"

print_header "Collecting endpoints"
echo "$domain" | gau --threads 5 >>"$domain/endpoints.txt"
cat "$domain/live_subdomains.txt" | katana -jc >>"$domain/endpoints.txt"

print_header "Removing duplicate endpoints with URO"
cat "$domain/endpoints.txt" | uro >>"$domain/endpoints_filtered.txt"

print_header "Using Gxss tool to test source code reflection"
cat "$domain/endpoints_filtered.txt" | Gxss -p khXSS -o "$domain/xss_ref.txt"

print_header "Starting Dalfox"
dalfox file "$domain/xss_ref.txt" -o "$domain/vulnerable_xss.txt"

print_header "Process Complete!"
echo "Results saved in the '$domain' directory."
