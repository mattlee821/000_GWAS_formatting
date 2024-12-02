#!/bin/bash

# Define the list of ancestries
ancestries=("central-south-asian")

# Loop through each ancestry
for ancestry in "${ancestries[@]}"; do
# Define the processed directory and missing file paths for the current ancestry
DIRECTORY_PROCESSED="/data/GWAS_data/files/sun_2023_PMID37794186/processed/${ancestry}/"
MISSING_FILE="/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_${ancestry}"

# List all .tar files, remove "_v1*" and save to the missing file
ls ${DIRECTORY_PROCESSED}*tar | sed 's/_v1.*$/.gz/' > ${MISSING_FILE}

done