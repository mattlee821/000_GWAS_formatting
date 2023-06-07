#!/bin/bash

#SBATCH --job-name=annotate-pheno-col
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/GWAS_data/files/agrawal_2022_PMID35773277/processed/

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *.txt; do
    awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : "phenotype")}' "$file" > "$tmp" &&
    mv -- "$tmp" "$file" || exit
done
