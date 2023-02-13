#!/bin/bash

#SBATCH --job-name=move-proteins-processed
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/raw

cp *gz /data/protein_GWAS_ferkingstad_EU_2021/files/processed/
