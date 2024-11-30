#!/bin/bash

# title: Check SNP Column
# description: Remove everything after the first ":" character in the "SNP" column
# if row 2 of the "SNP" column contains ":"

# Check if all required arguments are provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <FILE>"
  exit 1
fi

FILE="$1"

# Get the header row from the input file
header=$(awk -F'\t' 'NR==1 {print $0; exit}' "$FILE")
# Determine the column number for "SNP" in the header
column_number=$(echo "$header" | awk -F'\t' '{for (i=1; i<=NF; i++) if ($i == "SNP") print i}')

# Check if column_number is not empty
if [ -n "$column_number" ]; then
    # Check if row 2 of "SNP" column contains ":"
    has_colon=$(awk -v col="$column_number" 'NR==2 {split($col, a, ":"); if (length(a) > 1) print "true"; else print "false"}' "$FILE")

    if [ "$has_colon" == "true" ]; then
        # Create a temporary file for the modified data
        TEMP_FILE=$(mktemp)
        
        # Process the data to remove everything after the first ":"
        awk -v col="$column_number" 'BEGIN{FS=OFS="\t"} NR==1{print; next} {sub(/:.*/, "", $col); print}' "$FILE" > "$TEMP_FILE"
        
        # Replace the original file with the modified file
        mv "$TEMP_FILE" "$FILE"
        
        echo "* successfully removed everything after the first ':' in the 'SNP' column."
    else
        echo "# row 2 of 'SNP' column does not contain ':'. No action taken."
    fi
else
    echo "* column 'SNP' not found in the header."
fi
