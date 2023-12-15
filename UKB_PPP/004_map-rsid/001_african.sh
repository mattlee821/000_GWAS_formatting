#!/bin/bash

#SBATCH --job-name=map-rsid-african
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

# File to join with
file_to_join=/data/GWAS_data/files/UKB_PPP/Metadata/SNP_RSID_maps/combined.txt 

# Custom header row
custom_header="CHROM\tGENPOS\tID\tALLELE0\tALLELE1\tA1FREQ\tINFO\tN\tTEST\tBETA\tSE\tCHISQ\tLOG10P\tEXTRA\tphenotype\tID\tREF\tALT\trsid\tPOS19\tPOS38"

cd /data/GWAS_data/files/UKB_PPP/processed/african

# Loop through all gzipped files in the directory and perform the left join
for gz_file in *.gz; do
    # Create a temporary file to store the joined data
    temp_file=$(mktemp)

    # Add the custom header row to the temporary file
    echo -e "$custom_header" > "$temp_file"

    # Perform the left join using zcat, awk, and append the result to the temporary file
    zcat "$gz_file" | awk -v h="$header" 'FNR==NR {a[$1]=$0; next} FNR==1 {next} {key=$3; if (key in a) print $0, a[key]; else print $0, "NA NA NA"}' "$file_to_join" - >> "$temp_file"

    # Gzip the temporary file and replace the original gzipped file
    gzip "$temp_file"
    mv "${temp_file}.gz" "$gz_file"
done
