#!/bin/bash

#SBATCH --job-name=snplist-decode
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=10-10:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

# Define the directory containing your files
directory="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/GWAS"
# Define the combined output file
output_file="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/SNP-list_DECODE.txt"

# Remove the output file if it exists
rm -f "$output_file"

# Iterate over each file in the directory
for file in "$directory"/*gz
do
    echo "Extracting: $file"
    # Decompress the file on the fly and extract the fifth column, then append it to the output file
    zcat "$file" | awk '{print $4}' >> "$output_file"
done

# Sort the combined file and remove duplicate rows
sort -u "$output_file" -o "$output_file.sorted"
mv "$output_file.sorted" "$output_file"

echo "Combined file sorted and duplicate rows removed."
