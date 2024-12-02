#!/bin/bash

#SBATCH --job-name=
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00-2:0:00
#SBATCH --mem=15000M
#SBATCH --partition=low_p

export ID="ancestry"
cd /data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/002_standardise/002_standardise/filelist_${ID}/

VAR1=filelist-01

python ${VAR1}.py
