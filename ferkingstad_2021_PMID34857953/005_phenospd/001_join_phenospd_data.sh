#!/bin/bash

#SBATCH --job-name=join-phenospd-data
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/

paste -d " " ../work/snp_list results.filelist* > phenospd_data
