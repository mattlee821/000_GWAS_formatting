#!/bin/bash

#SBATCH --job-name=join-snp
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /home/leem/001_projects/000_GWAS_formatting/CRC_early-onset
Rscript 001_add-rsid.R

DATA=/data/GWAS_data/files/CRC_early-onset/processed/
gzip -f *.txt
