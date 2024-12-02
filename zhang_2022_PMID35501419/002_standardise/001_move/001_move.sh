#!/bin/bash

#SBATCH --job-name=move-data
#SBATCH --nodes=10
#SBATCH --ntasks-per-node=10
#SBATCH --time=20-1:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

FILES="/data/GWAS_data/files/"
DIRECTORY=zhang_2022_PMID35501419

# Run each rsync command in parallel
rsync -av "${FILES}${DIRECTORY}/raw/european/" "${FILES}${DIRECTORY}/processed/european/" &
rsync -av "${FILES}${DIRECTORY}/raw/african-american/" "${FILES}${DIRECTORY}/processed/african-american/" &

# Wait for all background jobs to finish
wait

echo "All rsync commands completed."
