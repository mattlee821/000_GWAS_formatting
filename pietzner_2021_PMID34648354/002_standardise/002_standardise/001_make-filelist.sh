#!/bin/bash

#SBATCH --job-name=make-multiple-submissionscripts
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

export ID="pietzner_2021_PMID34648354"

cd /data/GWAS_data/work/000_GWAS_formatting/${ID}/002_standardise/002_standardise/
mkdir -p filelist

export PATH_OUT="/data/GWAS_data/work/000_GWAS_formatting/${ID}/002_standardise/002_standardise/filelist/"
export FILE_OUT_PREFIX="filelist-"
find "${PATH_OUT}" -name "filelist-*" -type f -exec rm {} +
find "${PATH_OUT}" -name "slurm-*" -type f -exec rm {} +
ls /data/GWAS_data/files/${ID}/processed/*gz > filenames
export FILE_IN="/data/GWAS_data/work/000_GWAS_formatting/${ID}/002_standardise/002_standardise/filenames"

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

# Create multiple .sh scripts based on a master script
while IFS= read -r sh_file; do 
    # Extract the base filename
    base_filename=$(basename "$sh_file" .sh)
    
    # Use awk to process the master SLURM script
    awk -v fname="$base_filename" '{
        if (NR == 3) {
            print "#SBATCH --job-name=sd_" fname;
        } else if (NR == 10) {
            print "VAR1=\"" fname "\"";
        } else {
            print $0;
        }
    }' 001_master.sh > "${sh_file}.sh"

    echo "${base_filename}.sh"

done < filenames

# Generate Python scripts
while IFS= read -r filepath; do
    # Extract the base filename
    base_filename=$(basename "$filepath")
    
    # Use awk to process the master Python script
    awk -v fname="$base_filename" '{
        if (NR == 15) {
            print "VAR1=\"" fname "\"";
        } else {
            print $0;
        }
    }' 001_master.py > "${PATH_OUT}${base_filename}.py"

    echo "${base_filename}.py"

done < filenames
