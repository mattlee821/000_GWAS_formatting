#!/bin/bash

# Define the list of ancestries
ancestries=("middle-east" "african" "american" "central-south-asian" "combined" "east-asian")
ancestries=("central-south-asian")

# Define the parent directory
parent_dir="/data/GWAS_data/files/sun_2023_PMID37794186/processed/"

# Define the output directory
output_dir="/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/"
mkdir -p "$output_dir"  # Create the output directory if it doesn't exist

# Loop through each ancestry
for ancestry in "${ancestries[@]}"; do
    # Define the directory for the current ancestry
    sub_dir="${parent_dir}${ancestry}/"

    # Check if the directory exists
    if [[ ! -d "$sub_dir" ]]; then
        echo "Directory not found: $sub_dir"
        continue
    fi

    # Define the output file for the current ancestry
    output_file="${output_dir}filelist_${ancestry}"

    # Initialize (or clear) the output file
    > "$output_file"

    # Loop through each .gz file in the current directory
    for gz_file in "$sub_dir"*.gz; do
        # Check if any .gz files exist in the directory
        if [[ -e "$gz_file" ]]; then
            # Extract the first line from the .gz file
            first_line=$(zcat "$gz_file" | head -n 1)

            # Extract the filename (without the path)
            filename=$(basename "$gz_file")

            # Prepend the filename as the first column separated by a tab and append to the output file
            echo -e "${filename}\t${first_line}" >> "$output_file"
        fi
    done

    echo "Processed ancestry: $ancestry. Output saved to $output_file."
done

echo "Processing completed for all ancestries!"
