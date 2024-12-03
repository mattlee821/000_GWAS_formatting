#!/bin/bash

#SBATCH --job-name=move-GWAS
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

FILES=/data/GWAS_data/files/
WORK=/data/GWAS_data/work/
PROCESSED=/processed/
RAW=/raw/
DOCS=/docs/
GWAS=/GWAS/
DIRECTORY=ferkingstad_2021_PMID34857953

find "${FILES}${DIRECTORY}/" -type d -exec chmod 777 {} \;
find "${FILES}${DIRECTORY}/" -type f -exec chmod 777 {} \;

# move processed/
mkdir -p ${WORK}${DIRECTORY}/
mkdir -p ${WORK}${DIRECTORY}/${GWAS}
rsync -av "${FILES}${DIRECTORY}/${PROCESSED}" "${WORK}${DIRECTORY}/${GWAS}"
find "${WORK}${DIRECTORY}/${GWAS}" -type d -exec chmod 555 {} \;
find "${WORK}${DIRECTORY}/${GWAS}" -type f -exec chmod 555 {} \;

# make permissions for files/ user read only
find "${FILES}${DIRECTORY}/" -type d -exec chmod 555 {} \;
find "${FILES}${DIRECTORY}/" -type f -exec chmod 555 {} \;

# move docs/
mkdir -p ${WORK}${DIRECTORY}/
mkdir -p ${WORK}${DIRECTORY}/${DOCS}
rsync -av "${FILES}${DIRECTORY}/${DOCS}/" "${WORK}${DIRECTORY}/${DOCS}"
find "${WORK}${DIRECTORY}/${DOCS}" -type d -exec chmod 555 {} \;
find "${WORK}${DIRECTORY}/${DOCS}" -type f -exec chmod 555 {} \;
