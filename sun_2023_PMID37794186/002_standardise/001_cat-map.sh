#!/bin/bash

#SBATCH --job-name=cat-map
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

cd "/data/GWAS_data/files/sun_2023_PMID37794186/docs/SNP RSID maps/"

directory="/data/GWAS_data/files/sun_2023_PMID37794186/docs/SNP RSID maps/"

# Loop through all .gz files in the directory
for file in "$directory"/*.gz; do
  if [ -f "$file" ]; then
    gunzip "$file"  # Unzip the file
    echo "Unzipped: $file"
  fi
done

# cat
cat "$directory"/olink* > "$directory"/map_ID-rsid.txt
gzip "$directory"/map_ID-rsid.txt

# zip 
for file in "$directory"/olink*; do
  if [ -f "$file" ]; then
    gzip "$file"  # Zip the individual olink files
    echo "Zipped: $file"
  fi
done