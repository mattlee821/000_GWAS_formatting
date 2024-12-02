#!/bin/bash

#SBATCH --job-name=
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

export ID="pietzner_2021_PMID34648354"

cd /data/GWAS_data/work/000_GWAS_formatting/${ID}/002_standardise/001_move/filelist/
OUT=/data/GWAS_data/files/${ID}/processed/

VAR1=

# Download files
while IFS= read -r VAR2; do
  rsync -av "${VAR2}" "${OUT}"
done < "${VAR1}"
