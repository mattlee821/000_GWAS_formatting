#!/bin/bash

#SBATCH --job-name=annotate-filelist11
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/

export EXCLUSIONS=/data/protein_GWAS_ferkingstad_EU_2021/work/assocvariants.excluded.txt

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in `cat filelist11`; do
    gzip -d -c ${file} > ${file}.unzipped
    rm ${file}
    awk 'NR==FNR{++a[$3]} !a[$3]' $EXCLUSIONS ${file}.unzipped > ${tmp} &&
    mv -- ${tmp} ${file}.exclusions
    gzip ${file}.exclusions
    rm ${file}.unzipped ${file}.exclusions
done


