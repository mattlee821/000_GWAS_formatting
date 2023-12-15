#!/bin/bash

#SBATCH --job-name=standardise
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

SCRIPT=/home/leem/001_projects/000_GWAS_formatting/scripts/standardise/
DATA_IN=/data/GWAS_data/files/omara_2018_PMID30093612/raw/
DATA_OUT=/data/GWAS_data/files/omara_2018_PMID30093612/processed/
COLUMNS=/home/leem/001_projects/000_GWAS_formatting/omara_2018_PMID30093612/
FILE=ECAC2018_noUKBB.txt
cd ${SCRIPT}
./standardise.sh -i ${DATA_IN}${FILE} \
-o ${DATA_OUT} \
-columns ${COLUMNS}column_mapping_file_noUKB-data \
-phenotype endometrial-cancer
rm ${DATA_IN}${FILE}

SCRIPT=/home/leem/001_projects/000_GWAS_formatting/scripts/standardise/
DATA_IN=/data/GWAS_data/files/omara_2018_PMID30093612/raw/
DATA_OUT=/data/GWAS_data/files/omara_2018_PMID30093612/processed/
COLUMNS=/home/leem/001_projects/000_GWAS_formatting/omara_2018_PMID30093612/
FILE=ECAC2018_endometrioid.txt
cd ${SCRIPT}
./standardise.sh -i ${DATA_IN}${FILE} \
-o ${DATA_OUT} \
-columns ${COLUMNS}column_mapping_file_noUKB-data \
-phenotype endometrioid-cancer
rm ${DATA_IN}${FILE}

SCRIPT=/home/leem/001_projects/000_GWAS_formatting/scripts/standardise/
DATA_IN=/data/GWAS_data/files/omara_2018_PMID30093612/raw/
DATA_OUT=/data/GWAS_data/files/omara_2018_PMID30093612/processed/
COLUMNS=/home/leem/001_projects/000_GWAS_formatting/omara_2018_PMID30093612/
FILE=ECAC2018_nonendometrioid.txt
cd ${SCRIPT}
./standardise.sh -i ${DATA_IN}${FILE} \
-o ${DATA_OUT} \
-columns ${COLUMNS}column_mapping_file_noUKB-data \
-phenotype nonendometrioid-cancer
rm ${DATA_IN}${FILE}

