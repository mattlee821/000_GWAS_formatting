#!/bin/bash

#SBATCH --job-name=
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

export ID="test"
VAR1=filelist-01

conda init
conda activate main

cd /data/GWAS_data/work/000_GWAS_formatting/zhang_2022_PMID35501419/002_standardise/002_standardise/filelist_${ID}/

python ${VAR1}.py
