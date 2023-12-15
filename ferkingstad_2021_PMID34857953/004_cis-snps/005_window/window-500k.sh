#!/bin/bash

#SBATCH --job-name=window-500k-decode
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

FILE_IN="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/005_cissnps_filelist.txt"
while IFS=$'\t' read -r FILE_PATH CHR POS FILE_OUT; do
    FILE_NAME=$(basename "$FILE_PATH")
    # Print information about the current file
    echo "Processing: $FILE_NAME"
    echo "Searching for CHR: $CHR"
    echo "Searching for POS: $POS"

    zcat $FILE_PATH | awk '$1 == "'$CHR'" && ($2 >= ('$POS' - 500000) && $2 < ('$POS' + 500000)) { print $0 }' > ${FILE_OUT}
    echo "Line count for $FILE_OUT: $(wc -l < $FILE_OUT)"
done < "$FILE_IN"

mv /data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/window/*gz* /data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/window/500k/