#!/bin/bash

#SBATCH --job-name=phenospd
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

export SCRIPT=/home/leem/PhenoSpD/script/my_phenospd.r
export DATA=/data/protein_GWAS_ferkingstad_EU_2021/files/phenospd_data
export OUT=/data/protein_GWAS_ferkingstad_EU_2021/work/phenospd/all

cd /data/protein_GWAS_ferkingstad_EU_2021/files/

awk '!/!/' ${DATA} > /scratch/leem/phenospd_data

cd /home/leem/PhenoSpD/

Rscript ${SCRIPT} --sumstats /scratch/leem/phenospd_data --out ${OUT}
