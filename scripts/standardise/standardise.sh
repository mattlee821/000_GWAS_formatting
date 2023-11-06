#!/bin/bash
# title: GWAS standardisation
# description: this script takes a GWAS summary statistics file and standardises
# (1) copy file to the output directory
# (2) unarchive and convert to .txt
# (3) convert to a tab delimited file if it isn't already
# (4) add a phenotype column with a supplied value or the file name
# (5) rename required columns
# (6) format the SNP column if needed
# (7) zip the file
# (8) 

# Record the start time
start_time=$(date +%s)

# Default values
FILE_IN=""
DIRECTORY_OUT=""
PHENTOYPE=""
COLUMN_MAPPING_FILE=""

# Parse command-line options
while [ "$#" -gt 0 ]; do
  case "$1" in
    -i)
      FILE_IN="$2"
      shift 2
      ;;
    -o)
      DIRECTORY_OUT="$2"
      shift 2
      ;;
    -columns)
      COLUMN_MAPPING_FILE="$2"
      shift 2
      ;;
    -phenotype)
      PHENTOYPE="$2"
      shift 2
      ;;
    *)
      echo "Invalid option: $1" >&2
      exit 1
      ;;
  esac
done


# Check for missing or empty required arguments
if [ -z "$FILE_IN" ] || [ -z "$DIRECTORY_OUT" ]; then
  echo "Usage: $0 -i FILE_IN -o DIRECTORY_OUT -columns COLUMN_MAPPING_FILE [-phenotype PHENTOYPE]"
  exit 1
fi

# Extract the file name from the FILE_IN path
FILE_NAME=$(basename "$FILE_IN")
# Extract the directory path from the FILE_IN path
DIRECTORY_IN=$(dirname "$FILE_IN")

# START
echo "# Standardising your GWAS"
echo "* Input file: $FILE_NAME"
echo "* Input directory: $DIRECTORY_IN"
echo "* Output directory: $DIRECTORY_OUT"
echo "* Phenotype: $PHENTOYPE"

# Check if the output directory exists, and create it if not 
if [ ! -d "$DIRECTORY_OUT" ]; then
echo "* output directory doesn't exist, making it now"
  mkdir -p "$DIRECTORY_OUT"
else
echo "* output directory exists"
fi

# step 1: copy
# copy the input file from DIRECTORY_IN to DIRECTORY_OUT
echo "# Step 1: copying"
echo "* copying: $FILE_NAME to $DIRECTORY_OUT"
cp "$FILE_IN" "$DIRECTORY_OUT"
echo "* copying done"

# step 2: check archive
# check if the file is archived and convert it to .txt
if [[ "$FILE_NAME" != *.txt ]]; then # (if the file doesn't end with .txt)
  echo "# Step 2: check archive; unarchive"
  # source check_archive.sh to handle different archive types
  . ./check_archive.sh "$DIRECTORY_OUT/$FILE_NAME"
  check_archive_exit_code=$?  # store the exit code of check_archive.sh
  if [ $check_archive_exit_code -ne 0 ]; then
    echo "* ERROR: check archive failed; exiting."
    exit 1
  fi
  # remove the archived file
  echo "* removing archived file: $DIRECTORY_OUT/$FILE_NAME"
  rm "$DIRECTORY_OUT/$FILE_NAME"
  # get the new file name after archive check
  FILE_NAME=$(basename "$FILE_NAME_NEW")
  echo "* check archive done, new file name is: $FILE_NAME"
else
  echo "# Step 2: check archive"
  echo "* NA: file already is .txt"
fi

# step 3: check delimiter
# check what the delimiter of the file is and convert it to tab 
echo "# Step 3: check delimiter"
./check_delimiter.sh "$DIRECTORY_OUT/$FILE_NAME"
check_delimiter_exit_code=$?  # store the exit code of check_delimiter.sh
if [ $check_delimiter_exit_code -ne 0 ]; then
  echo "Delimiter check failed. Exiting."
  exit 1
fi
echo "* delimiter check done"

# step 4: check phenotype
# check if a phenotype is supplied and add it (or if not) or the file name to a
# a new column 
echo "# Step 4: check phenotype"
if [ -n "$PHENTOYPE" ]; then
  echo "* phenotype supplied: $PHENTOYPE"
  ./check_phenotype.sh "$DIRECTORY_OUT/$FILE_NAME" "$PHENTOYPE"
else
  echo "* phenotype not supplied, using file name: $FILE_NAME"
  ./check_phenotype.sh "$DIRECTORY_OUT/$FILE_NAME" "$FILE_NAME"
fi
check_phenotype_exit_code=$?  # store the exit code of check_phenotype.sh
if [ $check_phenotype_exit_code -ne 0 ]; then
  echo "* ERROR: phenotype check failed, exiting."
  exit 1
fi
echo "* phenotype check done"

# step 5: check columns
# change column names of required columns to standard form
echo "# Step 5: check columns"
echo "* column mapping file is here: $COLUMN_MAPPING_FILE"
echo "COLUMN_MAPPING_FILE: $COLUMN_MAPPING_FILE"
# Use AWK to change column names in the first line
awk 'FNR==NR { array[$1]=$2; next } FNR==1 { for (i in array) gsub("\\<"i"\\>", array[i]) } 1' "$COLUMN_MAPPING_FILE" "$DIRECTORY_OUT/$FILE_NAME" > "$DIRECTORY_OUT/column_mapping_$FILE_NAME"
change_column_exit_code=$?
if [ $change_column_exit_code -ne 0 ]; then
  echo "* ERROR: column name changes failed; exiting."
  exit 1
fi
mv "$DIRECTORY_OUT/column_mapping_$FILE_NAME" "$DIRECTORY_OUT/$FILE_NAME"
echo "* column name changes done"

# step 6: check SNP column
# remove everything after ":" in the "SNP_new" column if its present
echo "# Step 6: check SNP column"
# Get the header row from the input file
header=$(awk -F'\t' 'NR==1 {print $0; exit}' "$DIRECTORY_OUT/$FILE_NAME")
# Determine the column number for "SNP" in the header
column_number=$(echo "$header" | awk -F'\t' '{for (i=1; i<=NF; i++) if ($i == "SNP") print i}')
echo "* SNP column is position $column_number"
# Check if row 2 of "SNP" column contains ":"
has_colon=$(awk -F'\t' -v col="SNP" 'NR==2 {split($col, a, ":"); if (length(a) > 1) print "true"; else print "false"}' "$DIRECTORY_OUT/$FILE_NAME")
if [ "$has_colon" == "true" ]; then
    # Call check_SNP-column.sh
    echo "* SNP column contains ':'"
    ./check_SNP-column.sh "$DIRECTORY_OUT/$FILE_NAME"
else
    echo "* SNP column doesn't contain ':', no action taken."
fi
echo "* check SNP column done"

# Step 7: zip the file
echo "# Step 7: archive"
gzip "$DIRECTORY_OUT/$FILE_NAME"
zip_exit_code=$?

if [ $zip_exit_code -ne 0 ]; then
  echo "* ERROR: zipping the file failed; exiting."
  exit 1
fi
echo "* archiving done"

# END
echo "## standardising DONE ##"

# Record the end time
end_time=$(date +%s)
# Calculate the elapsed time
elapsed_seconds=$((end_time - start_time))
# Convert the elapsed time to minutes
elapsed_minutes=$(bc <<< "scale=2; $elapsed_seconds / 60")

# Print the elapsed time
echo "## elapsed time: ${elapsed_minutes} minutes ##"
