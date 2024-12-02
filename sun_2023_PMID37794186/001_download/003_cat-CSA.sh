#!/bin/bash
#SBATCH --job-name=cat-data-CSA
#SBATCH --nodes=10                  
#SBATCH --ntasks-per-node=40        
#SBATCH --time=10:00:00             
#SBATCH --mem=5000M                 
#SBATCH --partition=low_p 

DIRECTORY_PROCESSED="/data/GWAS_data/files/sun_2023_PMID37794186/processed/"
DIRECTORY_ANCESTRY="central-south-asian/"
cd "${DIRECTORY_PROCESSED}${DIRECTORY_ANCESTRY}"

# Function to process each .tar file
process_tar_file() {
  FILE_NAME_EXTENSION="$1"
  DIRECTORY="${FILE_NAME_EXTENSION%.tar}"

  # Extract the .tar file
  echo "Extracting $FILE_NAME_EXTENSION"
  tar -xvf ${FILE_NAME_EXTENSION}
  
  # Extract GWAS name using regex
  pattern="(.*)_v[0-9]+_"
  if [[ ${DIRECTORY} =~ $pattern ]]; then
    GWAS="${BASH_REMATCH[1]}"
    result="$GWAS"
  fi
  
  FILENAME=$(basename "$GWAS")

  # Unzip the GWAS files
  echo "Unzipping files in directory ${DIRECTORY}"
  gzip -d "${DIRECTORY}/"*
  
  # Concatenate the GWAS files
  echo "Concatenating files in directory ${DIRECTORY}"
  cat "${DIRECTORY}/"* > "${GWAS}"
  
  # Move the concatenated file to the main directory
  echo "Moving concatenated file ${GWAS} to ${DIRECTORY_PROCESSED}${DIRECTORY_ANCESTRY}"
  mv "${GWAS}" "${DIRECTORY_PROCESSED}${DIRECTORY_ANCESTRY}${FILENAME}"

  # Zip the concatenated file
  echo "Zipping concatenated file ${DIRECTORY_PROCESSED}${DIRECTORY_ANCESTRY}${FILENAME}"
  gzip "${DIRECTORY_PROCESSED}${DIRECTORY_ANCESTRY}${FILENAME}"
  
  # Cleanup: Remove the extracted directory and the original .tar file
  echo "Cleaning up: Removing directory ${DIRECTORY} and tar file ${FILE_NAME_EXTENSION}"
  rm -rf "${DIRECTORY}"         # Remove the extracted directory
  rm -f "${FILE_NAME_EXTENSION}" # Remove the original .tar file
}

export -f process_tar_file

# Find all .tar files, sort them in reverse alphabetical order, and run them in parallel
parallel -j 100 process_tar_file ::: $(find "${DIRECTORY_PROCESSED}${DIRECTORY_ANCESTRY}" -type f -name "*.tar" | sort -r)
