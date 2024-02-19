#!/bin/bash

#SBATCH --job-name=snplist-decode-cis
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=10-10:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

# Define the directory containing your files
directory="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/GWAS/"
# Define the combined output file
output_file="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/SNP-list_DECODE-cis.txt"
# define cis-snp files
awk '{print $7}' /data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis_snp_list.txt >> /data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/filelist_cis-snps.txt 
file_list="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/filelist_cis-snps.txt"
sed -i 's/\.txt\.gz\.annotated\.gz\.exclusions\.gz\.alleles\.gz\.unzipped/\.txt\.gz\.annotated\.gz\.exclusions\.gz\.alleles\.gz/g' "$file_list"

# Remove the output file if it exists
rm -f "$output_file"

# Iterate over each file in the directory
while IFS= read -r file; do
    echo "Extracting: $file"
    # Decompress the file on the fly and extract the fifth column, then append it to the output file
    zcat ${directory}"$file" | awk '{print $4}' >> "$output_file"
done < ${file_list}

# Sort the combined file and remove duplicate rows
sort -u "$output_file" -o "$output_file.sorted"
mv "$output_file.sorted" "$output_file"

echo "Combined file sorted and duplicate rows removed."
