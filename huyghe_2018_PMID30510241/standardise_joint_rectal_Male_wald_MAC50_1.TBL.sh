#!/bin/bash

#SBATCH --job-name=standardise
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M
#SBATCH --partition=low_p

SCRIPT=/home/leem/001_projects/000_GWAS_formatting/scripts/standardise/
DATA_IN=/data/GWAS_data/files/huyghe_2018_PMID30510241/raw/
DATA_OUT=/data/GWAS_data/files/huyghe_2018_PMID30510241/processed/
COLUMNS=/home/leem/001_projects/000_GWAS_formatting/huyghe_2018_PMID30510241/
FILE=joint_rectal_Male_wald_MAC50_1.TBL

cd ${SCRIPT}
./standardise.sh -i ${DATA_IN}${FILE} \
-o ${DATA_OUT} \
-columns ${COLUMNS}column_mapping_file \
-phenotype rectal_CRC
