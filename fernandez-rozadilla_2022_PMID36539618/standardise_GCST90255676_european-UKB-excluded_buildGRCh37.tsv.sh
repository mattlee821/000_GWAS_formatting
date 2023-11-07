#!/bin/bash

#SBATCH --job-name=standardise
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

SCRIPT=/home/leem/001_projects/000_GWAS_formatting/scripts/standardise/
DATA_IN=/data/GWAS_data/files/fernandez-rozadilla_2022_PMID36539618/raw/
DATA_OUT=/data/GWAS_data/files/fernandez-rozadilla_2022_PMID36539618/processed/
COLUMNS=/home/leem/001_projects/000_GWAS_formatting/fernandez-rozadilla_2022_PMID36539618/
FILE=GCST90255676_european-UKB-excluded_buildGRCh37.tsv

cd ${SCRIPT}
./standardise.sh -i ${DATA_IN}${FILE} \
-o ${DATA_OUT} \
-columns ${COLUMNS}column_mapping_file \
-phenotype CRC