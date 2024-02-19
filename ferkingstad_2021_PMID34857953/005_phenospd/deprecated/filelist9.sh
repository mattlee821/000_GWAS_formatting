#!/bin/bash

#SBATCH --job-name=join-test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/

export REMOVE=.txt.gz.annotated.gz.exclusions.gz.alleles.gz

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }

for file in `cat filelist9`; do
    gzip -d -c ${file} > ${file}.unzipped # unzip GWAS

    export colNAME=$(echo $file | sed -e "s/$REMOVE$//" | tr _ .) # remove strings from filename to make colNAME var

    sed  -i "1i Chrom Pos Name rsids effectAllele otherAllele ${colNAME}_b Pval min_log10_pval ${colNAME}_se N ImpMAF Phenotype A1 A2 EAF" ${file}.unzipped # add header

    join --nocheck-order -a1 -a2  -1 1 -2 3 -e 'NA' -o '2.7,2.10' ../work/snp_list ${file}.unzipped > filelist9.${file}.unzipped

    rm ${file}.unzipped 
done

paste -d " " ../work/snp_list filelist9.* > results.filelist9
rm filelist9.*
