#!/bin/bash

#SBATCH --job-name=extract-cissnps
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M
#SBATCH --partition=low_p

FILE_IN="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/002_filename-cissnps.txt"
FILE_OUT="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/003_cissnps.txt"

# Read the CSV file line by line
while IFS=$'\t' read -r filename search_string; do
    # Print the filename and search string
    echo "Searching '$(basename "$filename")' for '$search_string'"
    
    # Use zgrep to search for the string in the gzipped file
    if zgrep -w "$search_string" "$filename" >> "$FILE_OUT"; then

        # Print a message if the string is found
        echo "String '$search_string' found in '$(basename "$filename")'"
    else
        echo "String '$search_string' NOT found in '$(basename "$filename")'"
    fi
done < "$FILE_IN"