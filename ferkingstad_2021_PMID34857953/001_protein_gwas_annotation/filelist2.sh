#!/bin/bash

#SBATCH --job-name=annotate-filelist2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in `cat filelist2`; do
    gzip -d -c ${file} > ${file}.unzipped
    rm ${file}
    awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : "phenotype")}' ${file}.unzipped > ${tmp} &&
    mv -- ${tmp} ${file}.annotated
    gzip ${file}.annotated
    rm ${file}.unzipped ${file}.annotated
done