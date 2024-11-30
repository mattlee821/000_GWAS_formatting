#!/bin/bash
#SBATCH --job-name=standardise
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M
 
# change
DATA=
FILE=
PHENOTYPE=
 
# dont change
SCRIPT=/data/GWAS_data/work/000_GWAS_formatting/000_scripts/standardise/
DATA_IN=/data/GWAS_data/files/${DATA}/raw/
DATA_OUT=/data/GWAS_data/files/${DATA}/processed/
COLUMNS=/data/GWAS_data/work/000_GWAS_formatting/${DATA}/002_standardise/
 
# run
cd ${SCRIPT}
./standardise.sh -i ${DATA_IN}${FILE} \
-o ${DATA_OUT} \
-columns ${COLUMNS}column_mapping_file \
-phenotype ${PHENOTYPE}