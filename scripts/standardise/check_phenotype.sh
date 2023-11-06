#!/bin/bash

# title: check phenotype
# description: create a new column called phenotype and populate with the
# supplied value or the file name

# check if all required arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <FILE> <PHENOTYPE_VALUE>"
  exit 1
fi

FILE="$1"
PHENOTYPE_VALUE="$2"

# create a temporary file for the modifications
TEMP_FILE=$(mktemp)

# create a new tab-separated column with the header "phenotype" and populate it with the specified value
awk -v OFS='\t' -v header="phenotype" -v phenotype="$PHENOTYPE_VALUE" 'NR==1 {print $0, header} NR>1 {print $0, phenotype}' "$FILE" > "$TEMP_FILE"

# replace the original file with the modified file
mv "$TEMP_FILE" "$FILE"
