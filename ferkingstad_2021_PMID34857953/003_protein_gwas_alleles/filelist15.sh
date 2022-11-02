#!/bin/bash

#SBATCH --job-name=alleles-filelist15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/

export EXCLUSIONS=/data/protein_GWAS_ferkingstad_EU_2021/work/assocvariants.annotated.sorted.txt

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in `cat filelist15`; do
    gzip -d -c ${file} > ${file}.unzipped
    rm ${file}
    sort -k3 ${file}.unzipped > ${file}.unzipped.sorted
    join --nocheck-order -t $'\t' -1 3 -2 3 -o 1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,2.5,2.6,2.7 ${file}.unzipped.sorted $EXCLUSIONS > ${tmp} &&
    mv -- ${tmp} ${file}.alleles
    gzip ${file}.alleles
    rm ${file}.unzipped ${file}.unzipped.sorted
done

