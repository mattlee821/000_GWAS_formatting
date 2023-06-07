#!/bin/bash

#SBATCH --job-name=cat-data-csa
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

DIRECTORY_RAW=/data/GWAS_data/files/UKB_PPP/raw
DIRECTORY_PROCESSED=/data/GWAS_data/files/UKB_PPP/processed
DIRECTORY_ANCESTRY=central_south_asian

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }

cd ${DIRECTORY_RAW}/${DIRECTORY_ANCESTRY}

# Loop through the files and unzip
for FILE_NAME_EXTENSION in *.tar; do
  DIRECTORY="${FILE_NAME_EXTENSION%.tar}"
tar -xvf ${FILE_NAME_EXTENSION}

# extract GWAS name
## Set the pattern to match and extract the desired string
pattern="(.*)_v[0-9]+_"

## Loop through the folders and extract the string
  if [[ ${DIRECTORY} =~ $pattern ]]; then
    GWAS_NAME="${BASH_REMATCH[1]}"
    result="$GWAS_NAME"
  fi

# unzip GWAS
echo "unzip"
gzip -d ${DIRECTORY}/*

# cat GWAS
echo "cat"
cat ${DIRECTORY}/* > ${DIRECTORY}/${GWAS_NAME}

# add phenotype col
echo "phenotype col"
awk -v gwas_name="$GWAS_NAME" 'BEGIN {OFS=" "} {print $0, (NR==1 ? "phenotype" : gwas_name)}' "${DIRECTORY}/${GWAS_NAME}" > ${tmp} &&
mv -- ${tmp}  ${DIRECTORY}/${GWAS_NAME}

# move to processed
echo "move"
mv ${DIRECTORY}/${GWAS_NAME} ${DIRECTORY_PROCESSED}/${DIRECTORY_ANCESTRY}

# zip
echo "zip"
gzip ${DIRECTORY_PROCESSED}/${DIRECTORY_ANCESTRY}/${GWAS_NAME}

# clean up
rm -rf ${DIRECTORY}/

done
