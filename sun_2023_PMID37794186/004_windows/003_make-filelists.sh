#!/bin/bash

#SBATCH --job-name=make-multiple-submissionscripts
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

export ID="sun_2023_PMID37794186"
ancestries=("african"  "american"  "central-south-asian"  "combined"  "east-asian"  "european"  "middle-east")
cd /data/GWAS_data/work/000_GWAS_formatting/${ID}/004_windows/

# Loop through each ancestry directory
for ancestry in "${ancestries[@]}"; do
    export DIRECTORY_ANCESTRY="$ancestry"

    # Create necessary directories
    cd /data/GWAS_data/work/000_GWAS_formatting/${ID}/004_windows/
    mkdir -p filelist_${DIRECTORY_ANCESTRY}

    # Define paths
    export PATH_OUT="/data/GWAS_data/work/000_GWAS_formatting/${ID}/004_windows/filelist_${DIRECTORY_ANCESTRY}/"
    export FILE_OUT_PREFIX="filelist-"
    
    # Clean up old files
    find "${PATH_OUT}" -name "filelist-*" -type f -exec rm {} +
    find "${PATH_OUT}" -name "slurm-*" -type f -exec rm {} +
    
    # Create one file per line in FILE_IN
    export FILE_IN="/data/GWAS_data/work/000_GWAS_formatting/${ID}/004_windows/files_${DIRECTORY_ANCESTRY}.txt"
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
    
    # Verify consistency
    wc -l ${FILE_IN}
    wc -l ${PATH_OUT}filelist-* | tail -n 1
    ls ${PATH_OUT}filelist-* > filenames
    wc -l filenames

    # make master script copies
    while IFS= read -r sh_file; do 
        # Extract the base filename
        base_filename=$(basename "$sh_file" .sh)
        
        # Generate version 1
        awk -v fname="$base_filename" -v ancestry="${DIRECTORY_ANCESTRY}" '{
            if (NR == 3) 
                print "#SBATCH --job-name=window_" ancestry "-" fname;
            else if (NR == 10)
                print "export ID=\"" ancestry "\"";
            else if (NR == 11)
                print "export FILE=\"" fname "\"";
            else if (NR == 14)
                print "export WINDOW=1000000"; 
            else
                print $0
        }' 002_master.sh > "${sh_file}.sh"  
    
        echo "Created: ${sh_file}.sh"
    
    done < filenames

done

