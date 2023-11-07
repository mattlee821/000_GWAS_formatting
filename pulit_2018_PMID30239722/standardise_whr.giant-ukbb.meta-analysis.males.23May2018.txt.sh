#!/bin/bash

#SBATCH --job-name=standardise
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

SCRIPT=/home/leem/001_projects/000_GWAS_formatting/scripts/standardise/
DATA_IN=/data/GWAS_data/files/pulit_2018_PMID30239722/raw/
DATA_OUT=/data/GWAS_data/files/pulit_2018_PMID30239722/processed/
COLUMNS=/home/leem/001_projects/000_GWAS_formatting/pulit_2018_PMID30239722/
FILE=whr.giant-ukbb.meta-analysis.males.23May2018.txt

cd ${SCRIPT}
./standardise.sh -i ${DATA_IN}${FILE} \
-o ${DATA_OUT} \
-columns ${COLUMNS}column_mapping_file \
-phenotype WHR

