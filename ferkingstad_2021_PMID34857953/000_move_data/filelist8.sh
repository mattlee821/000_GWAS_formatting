#!/bin/bash

#SBATCH --job-name=mv-filelist8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/processed/

for file in $(cat filelist8); do
    cp "$file" "/data/protein_GWAS_ferkingstad_EU_2021/files/processed/"
done