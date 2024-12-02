#!/bin/bash

#SBATCH --job-name=
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00-2:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

VAR1=filelist-01

conda init
conda activate main

cd /data/GWAS_data/work/000_GWAS_formatting/pietzner_2021_PMID34648354/002_standardise/002_standardise/filelist/

python ${VAR1}.py
