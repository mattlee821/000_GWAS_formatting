#!/bin/bash

#SBATCH --job-name=move-data
#SBATCH --nodes=10
#SBATCH --ntasks-per-node=10
#SBATCH --time=20-1:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

FILES="/data/GWAS_data/files/"
DIRECTORY=sun_2023_PMID37794186

# Run each rsync command in parallel
# rsync -av "${FILES}${DIRECTORY}/raw/African/" "${FILES}${DIRECTORY}/processed/african/" &
# rsync -av "${FILES}${DIRECTORY}/raw/American/" "${FILES}${DIRECTORY}/processed/american/" &
rsync -av "${FILES}${DIRECTORY}/raw/Central_South Asian/" "${FILES}${DIRECTORY}/processed/central-south-asian/" &
rsync -av "${FILES}${DIRECTORY}/raw/Combined/" "${FILES}${DIRECTORY}/processed/combined/" &
# rsync -av "${FILES}${DIRECTORY}/raw/East Asian/" "${FILES}${DIRECTORY}/processed/east-asian/" &
# rsync -av "${FILES}${DIRECTORY}/raw/European (discovery)/" "${FILES}${DIRECTORY}/processed/european/" &
# rsync -av "${FILES}${DIRECTORY}/raw/Middle East/" "${FILES}${DIRECTORY}/processed/middle-east/" &

# Wait for all background jobs to finish
wait

echo "All rsync commands completed."
