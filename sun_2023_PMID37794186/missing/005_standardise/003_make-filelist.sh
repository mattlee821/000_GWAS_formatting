#!/bin/bash

#SBATCH --job-name=make-multiple-submissionscripts
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

export ID="sun_2023_PMID37794186"
ancestries=("african"  "american"  "central-south-asian"  "combined"  "east-asian"  "middle-east")
cd /data/GWAS_data/work/000_GWAS_formatting/${ID}/missing/005_standardise/
ancestries=("central-south-asian")

# Base directories
BASE_DIR="/data/GWAS_data/work/000_GWAS_formatting/${ID}/missing"
BASE_PROCESSED_DIR="/data/GWAS_data/files/${ID}/processed"

# Loop through each ancestry
for ancestry in "${ancestries[@]}"; do
    export DIRECTORY_ANCESTRY="$ancestry"
    
    # Paths for file lists and output
    FILE_LIST="${BASE_DIR}/filelist_${DIRECTORY_ANCESTRY}"
    PATH_OUT="${BASE_DIR}/005_standardise/filelist_${DIRECTORY_ANCESTRY}/"
    mkdir -p "$PATH_OUT"

    echo "Processing ancestry: $ancestry"
    
    # Clean up old files
    find "${PATH_OUT}" -name "filelist-*" -type f -exec rm {} +
    find "${PATH_OUT}" -name "slurm-*" -type f -exec rm {} +

    # Process each line in the file list
    i=1
    while IFS= read -r line; do
        # Format the number with leading zeros
        printf -v num "%02d" "$i"
        
        # Create a file for each input line
        echo "$line" > "${PATH_OUT}filelist-${num}"
        
        echo "filelist-${num}"
        i=$((i + 1))
    done < "$FILE_LIST"

    # Verify consistency
    echo "Verification for $ancestry:"
    wc -l "$FILE_LIST"
    wc -l "${PATH_OUT}"filelist-* | tail -n 1
    ls "${PATH_OUT}"filelist-* > "${PATH_OUT}/filenames"
    wc -l "${PATH_OUT}/filenames"

    # Generate SLURM .sh scripts
    while IFS= read -r sh_file; do 
        base_filename=$(basename "$sh_file")
        
        awk -v fname="$base_filename" -v ancestry="${DIRECTORY_ANCESTRY}" '{
            if (NR == 3) 
                print "#SBATCH --job-name=sd_" ancestry "-" fname;
            else if (NR == 10) {
                print "export ID=\"" ancestry "\"";
            } else if (NR == 13)
                print "VAR1=\"" fname "\"";
            else {
                print $0;
            }
        }' 002_master.sh > "${PATH_OUT}${base_filename}.sh"
        
        echo "${base_filename}.sh"
    
    done < "${PATH_OUT}/filenames"

    # Generate Python scripts
    while IFS= read -r filepath; do
        base_filename=$(basename "$filepath")
        
        awk -v fname="$base_filename" -v ancestry="${DIRECTORY_ANCESTRY}" '{
            if (NR == 11) {
                print "DIRECTORY_ANCESTRY=\"" ancestry "\"";
            } else if (NR == 12) {
                print "VAR1=\"" fname "\"";
            } else {
                print $0;
            }
        }' 002_master.py > "${PATH_OUT}${base_filename}.py"
        
        echo "${base_filename}.py"
    
    done < "${PATH_OUT}/filenames"
done
