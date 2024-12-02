# Define the list of ancestries
ancestries=("african" "american" "central-south-asian" "combined" "east-asian" "european" "middle-east")
ancestries=("central-south-asian")

# Loop through each ancestry
for ancestry in "${ancestries[@]}"; do
  # Define the directory and file list based on ancestry
  export DIRECTORY="/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/"
  export FILE="filelist_${ancestry}"

  # Define the output directory for the processed files, including the ancestry directory
  export DIRECTORY_OUT="/data/GWAS_data/files/sun_2023_PMID37794186/processed/${ancestry}/"

  # Create or clear the temporary file for storing matched files
  > /tmp/matched_files.txt

  # Loop over each line in the ancestry-specific filelist
  while read -r file_path; do
    # Remove leading/trailing spaces (if any)
    file_path=$(echo "$file_path" | xargs)

    # Extract the base filename (without directory and extension)
    base_filename=$(basename "$file_path")

    # Extract the directory from the path (assuming file_path contains the full directory path)
    directory_name=$(dirname "$file_path" | xargs)

    # Use find to perform a lazy match, looking for any file starting with base_filename and allowing for extensions like .tar
    matching_files=$(find "$directory_name" -type f -name "$base_filename*" -print)

    # If matching files are found, add them to the list for rsync
    if [ -n "$matching_files" ]; then
      echo "$matching_files" >> /tmp/matched_files.txt
    else
      echo "No match found for $file_path"
    fi
  done < "${DIRECTORY}${FILE}"

  # Check if any files were matched
  if [[ -s /tmp/matched_files.txt ]]; then
    # Perform rsync to copy the files to the specified output directory, including the ancestry directory
    rsync -av --no-relative --files-from=/tmp/matched_files.txt / "${DIRECTORY_OUT}"
  else
    echo "No files matched for ancestry: ${ancestry}, rsync not executed."
  fi
done



# DIRECTORY_IN="/data/GWAS_data/files/sun_2023_PMID37794186/raw/Combined/"
# DIRECTORY_OUT="/data/GWAS_data/files/sun_2023_PMID37794186/processed/combined/"
# FILE="SH2B3_Q9UQQ2_OID21222"*
# ls ${DIRECTORY_IN}${FILE}
# rsync -av ${DIRECTORY_IN}${FILE} ${DIRECTORY_OUT}



