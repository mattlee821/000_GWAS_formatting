#!/bin/bash

#SBATCH --job-name=move-data
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=11
#SBATCH --time=20-1:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

FILES="/data/GWAS_data/files/"
DIRECTORY=ferkingstad_2021_PMID34857953

# Run each rsync command in parallel
rsync -av "${FILES}${DIRECTORY}/raw/" "${FILES}${DIRECTORY}/processed/" 

