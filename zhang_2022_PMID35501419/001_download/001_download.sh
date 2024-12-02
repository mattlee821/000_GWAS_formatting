#!/bin/bash

#SBATCH --job-name=download
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

cd /data/GWAS_data/files/zhang_2022_PMID35501419/raw

wget https://jh-pwas.s3.amazonaws.com/results/EA.zip
wget https://jh-pwas.s3.amazonaws.com/results/AA.zip
wget https://jh-pwas.s3.amazonaws.com/results/seqid.txt
mv seqid.txt ../docs

mkdir -p european
mkdir -p afircan-american

unzip EA.zip
mv EA european
rm -rf EA.zip
unzip AA.zip
mv AA african-american
rm -rf AA.zip
