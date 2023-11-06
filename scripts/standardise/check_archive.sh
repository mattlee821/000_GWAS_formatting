#!/bin/bash

# Usage: ./check_archive.sh <FILE>

# title: check archive
# description: identify the archive (.gz, .zip, .tar) and unarchive/unzip

FILE="$1"
FILE_NAME_NEW="$FILE"  # Initialize FILE_NAME_NEW to be the same as the input file

# Check if the file ends with .gz
if [[ "$FILE" == *.gz ]]; then
  # Extract .gz file in place
  echo "* file is .gz; extracting"
  gunzip -c "$FILE" > "${FILE%.gz}"
  # Update FILE_NAME_NEW with the new name after extraction
  FILE_NAME_NEW="${FILE%.gz}"
  export FILE_NAME_NEW
elif [[ "$FILE" == *.zip ]]; then
  # Unzip .zip file in place
  echo "* file is .zip; unzipping"
  unzip -o "$FILE" -d "$(dirname "$FILE")"
  # Update FILE_NAME_NEW with the new name after extraction
  FILE_NAME_NEW="${FILE%.zip}"
  export FILE_NAME_NEW
elif [[ "$FILE" == *.tar ]]; then
  # Extract .tar file in place
  echo "* file is .tar; unzipping"
  tar -xf "$FILE" -C "$(dirname "$FILE")"
  # Update FILE_NAME_NEW with the new name after extraction
  FILE_NAME_NEW="${FILE%.tar}"
  export FILE_NAME_NEW
elif [[ "$FILE" != *.txt ]]; then
  # Handle other cases (unrecognized extensions)
  # Rename the file with .txt extension
  echo "* file is not .gz, .zip, .tar, or .txt; renaming as .txt"
  mv "$FILE" "${FILE%.*}.txt"
  # Update FILE_NAME_NEW with the new name after renaming
  FILE_NAME_NEW="${FILE%.*}.txt"
  export FILE_NAME_NEW
fi
