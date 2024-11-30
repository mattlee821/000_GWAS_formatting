#!/bin/bash

#SBATCH --job-name=download
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

# change
DATA=name_year_PMID # name of YOUR data folder
ACCESSION=GCST90016001-GCST90017000/ # 
STUDY=GCST90016666/ # change this
GWAS=harmonised/34128465-GCST90016666-EFO_0004324.h.tsv.gz # change this
TRAIT=liver-volume # change this

# dont change
URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt

# download
cd /data/GWAS_data/files/${DATA}
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}
