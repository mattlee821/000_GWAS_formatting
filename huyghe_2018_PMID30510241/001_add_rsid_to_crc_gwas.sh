#!/bin/bash

#SBATCH --job-name=join-snp
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

DATA=/data/GWAS_data/files/huyghe_2018_PMID30510241/processed/
cd ${DATA}
gzip -f *.txt
