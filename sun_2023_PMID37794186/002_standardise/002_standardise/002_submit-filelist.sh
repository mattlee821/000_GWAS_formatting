#!/bin/bash

#SBATCH --job-name=submit-jobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

# Set the base directory
export DIRECTORY="/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/002_standardise/002_standardise/"

# Define the list of ancestry folders
ancestry_folders=("filelist_african" "filelist_central-south-asian" "filelist_east-asian" "filelist_american" "filelist_combined" "filelist_european")

# Set batch size
batch_size=100

# Loop over each ancestry folder
for ancestry_folder in "${ancestry_folders[@]}"; do
    # Construct the full directory path for the current ancestry folder
    ancestry_directory="${DIRECTORY}${ancestry_folder}"

    # Ensure the directory exists
    if [ -d "$ancestry_directory" ]; then
        # Change to the ancestry directory
        cd "$ancestry_directory"

        # Find all .sh files in the directory
        sh_files=($ancestry_directory/*.sh)

        # Get the total number of .sh files
        total_files=${#sh_files[@]}

        # Loop through the files in batches of 100
        for ((i=0; i<total_files; i+=batch_size)); do
            # Submit the batch of 100 files
            for ((j=i; j<i+batch_size && j<total_files; j++)); do
                # Submit the .sh file
                qsub "${sh_files[$j]}"
            done

            # Optionally add a delay to avoid overloading the scheduler (e.g., 1-second pause)
            sleep 1
        done
    else
        echo "Directory $ancestry_directory does not exist. Skipping..."
    fi
done
