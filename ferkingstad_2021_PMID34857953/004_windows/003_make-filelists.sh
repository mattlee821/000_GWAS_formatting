#!/bin/bash

#SBATCH --job-name=make-multiple-submissionscripts
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

cd /data/GWAS_data/work/000_GWAS_formatting/ferkingstad_2021_PMID34857953/004_windows/
mkdir -p filelist

export PATH_OUT="/data/GWAS_data/work/000_GWAS_formatting/ferkingstad_2021_PMID34857953/004_windows/filelist/"
export FILE_OUT_PREFIX="filelist-"
find "${PATH_OUT}" -name "filelist-*" -type f -exec rm {} +
find "${PATH_OUT}" -name "slurm-*" -type f -exec rm {} +
export FILE_IN="/data/GWAS_data/work/000_GWAS_formatting/ferkingstad_2021_PMID34857953/004_windows/files.txt"

# Create one file per line in FILE_IN
i=1
while IFS= read -r line; do
    # Skip the first row (i.e., when i is 1)
    if [ "$i" -eq 1 ]; then
        i=$((i + 1))  # Increment the counter and skip processing
        continue
    fi
    
    # Format the number with leading zeros
    printf -v num "%02d" "$((i - 1))"  # Decrement i for file naming starting from 01

    # Create the file
    echo "$line" > "${PATH_OUT}${FILE_OUT_PREFIX}${num}"

    # Print the filename to the screen
    echo "${FILE_OUT_PREFIX}${num}"

    # Increment the counter
    i=$((i + 1))
done < "$FILE_IN"

# check the number of files is consistent  
wc -l ${FILE_IN}
wc -l ${PATH_OUT}filelist-* | tail -n 1
ls ${PATH_OUT}filelist-* > filenames

# make master script copies
while IFS= read -r sh_file; do 
    # Extract the base filename
    base_filename=$(basename "$sh_file" .sh)
    
    # Generate version 1
    awk -v fname="$base_filename" '{
        if (NR == 3) 
            print "#SBATCH --job-name=window_" fname;  
        else if (NR == 10)
            print "FILE_IN=\"/data/GWAS_data/work/000_GWAS_formatting/ferkingstad_2021_PMID34857953/004_windows/filelist/" fname "\"";  
        else if (NR == 12)
            print "WINDOW=1000000"; 
        else
            print $0
    }' 002_master.sh > "${sh_file}.sh"  

    echo "Created: ${sh_file}.sh"

done < filenames

