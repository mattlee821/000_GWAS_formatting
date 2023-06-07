#!/bin/bash

directory=""  # Directory containing the files
new_header=""  # New header row; use \t with no space for tab delimiter

for filename in "$directory"/*; do
    # Check if the file is a regular file
    if [ -f "$filename" ]; then
        # Create a temporary file
        temp_file=$(mktemp)

        # Replace the header row with the new header in the temporary file using tab delimiter
        sed "1s~.*~$new_header~" "$filename" > "$temp_file"

        # Replace the original file with the temporary file
        mv "$temp_file" "$filename"

        # Clean up the temporary file
        rm "$temp_file"

    fi
done
