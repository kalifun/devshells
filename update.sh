#!/bin/bash

# If no directory arguments are provided, show usage instructions
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory1> <directory2> ... <directoryN>"
    exit 1
fi

# Iterate through all provided directories
for dir in "$@"; do
    # Check if the directory exists
    if [ ! -d "$dir" ]; then
        echo "Warning: $dir is not a valid directory, skipping"
        continue
    fi
    
    # Find flake.nix files in the directory and its subdirectories, then run nix flake update
    find "$dir" -type f -name "flake.nix" -print0 | while IFS= read -r -d '' file; do
        flake_dir="$(dirname "$file")"
        echo "Updating flake in $flake_dir..."
        (cd "$flake_dir" && nix flake update)
        
        if [ $? -ne 0 ]; then
            echo "Warning: Failed to run nix flake update in $flake_dir"
        fi
    done
done
