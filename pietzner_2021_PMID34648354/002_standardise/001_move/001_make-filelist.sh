#!/bin/bash

#SBATCH --job-name=make-multiple-submissionscripts
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

export ID="pietzner_2021_PMID34648354"

# Change to the target directory
cd /data/GWAS_data/work/000_GWAS_formatting/${ID}/002_standardise/001_move/
mkdir -p filelist

export PATH_OUT="/data/GWAS_data/work/000_GWAS_formatting/${ID}/002_standardise/001_move/filelist/"
export FILE_OUT_PREFIX="filelist-"
find "${PATH_OUT}" -name "filelist-*" -type f -exec rm {} +
find "${PATH_OUT}" -name "slurm-*" -type f -exec rm {} +
ls "/data/GWAS_data/files/pietzner_2021_PMID34648354/raw/"*gz > filenames
export FILE_IN="/data/GWAS_data/work/000_GWAS_formatting/${ID}/002_standardise/001_move/filenames"

# Create one file per line in FILE_IN
i=1
while IFS= read -r line; do
    # Format the number with leading zeros
    printf -v num "%02d" "$i"
    
    # Create the file
    echo "$line" > "${PATH_OUT}${FILE_OUT_PREFIX}${num}"
    
    # Print the filename to the screen
    echo "${FILE_OUT_PREFIX}${num}"

    # Increment the counter
    i=$((i + 1))
done < "$FILE_IN"

# Check the number of files is consistent  
wc -l ${FILE_IN}
wc -l ${PATH_OUT}filelist-* | tail -n 1
ls ${PATH_OUT}filelist-* > filenames
wc -l filenames

# Create multiple .sh scripts from a single file with names based on a master script
cat filenames | while read i; do 
    # Print just the basename
    base_filename=$(basename "$i")
    echo "${base_filename}"
    
    # Generate the .sh script based on 001_master.sh
    awk '{ 
      if (NR == 3) 
        print "#SBATCH --job-name=mv_'${base_filename}'";
      else if (NR == 15)
        print "VAR1='${base_filename}'";
      else
        print $0
    }' 001_master.sh > ${i}.sh
done
