#!/bin/bash

#SBATCH --job-name=window-500k-UKB-EU
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

FILE_IN="/data/GWAS_data/work/UKB_PPP/cis-snps/003_cissnps-discovery-EU_filelist.txt"
OUTPUT_FOLDER="/data/GWAS_data/work/UKB_PPP/cis-snps/european/500k"

while IFS=$'\t' read -r FILE_PATH CHR POS FILE_OUT; do
    FILE_NAME=$(basename "$FILE_PATH")
    # Print information about the current file
    echo "Processing: $FILE_NAME"
    echo "Searching for CHR: $CHR"
    echo "Searching for POS: $POS"
    
    zcat "$FILE_PATH" | awk -v chr="$CHR" -v pos="$POS" '$1 == chr && ($20 >= (pos - 500000) && $20 < (pos + 500000)) { print $0 }' > "${FILE_OUT}"
    
    echo "Line count for $FILE_OUT: $(wc -l < "${FILE_OUT}")"

    # Move the created file to the 500k folder
    mv "${FILE_OUT}" "$OUTPUT_FOLDER/"
    
    echo "File moved to $OUTPUT_FOLDER/"
done < "$FILE_IN"
