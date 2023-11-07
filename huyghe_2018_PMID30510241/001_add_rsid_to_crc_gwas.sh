#!/bin/bash

#SBATCH --job-name=join-snp
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /home/leem/001_projects/000_GWAS_formatting/huyghe_2018_PMID30510241
Rscript 001_add_rsid_to_crc_gwas.R

DATA=/data/GWAS_data/files/huyghe_2018_PMID30510241/processed/
gzip -f *.txt
