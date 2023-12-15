#!/bin/bash

#SBATCH --job-name=window-1mb-UKB-nonEU
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

FILE_IN="/data/GWAS_data/work/UKB_PPP/cis-snps/003_cissnps-replicationn-nonEU_filelist.txt"
while IFS=$'\t' read -r FILE_PATH CHR POS FILE_OUT; do
    FILE_NAME=$(basename "$FILE_PATH")
    # Print information about the current file
    echo "Processing: $FILE_NAME"
    echo "Searching for CHR: $CHR"
    echo "Searching for POS: $POS"

    zcat $FILE_PATH | awk '$1 == '$CHR' && ($20 >= ('$POS' - 1000000) && $20 < ('$POS' + 1000000)) { print $0 }' > ${FILE_OUT}
    echo "Line count for $FILE_OUT: $(wc -l < $FILE_OUT)"
done < "$FILE_IN"

mv /data/GWAS_data/work/UKB_PPP/cis-snps/non-european/*gz* 1mb/