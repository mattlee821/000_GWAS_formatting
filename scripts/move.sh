#!/bin/bash

#SBATCH --job-name=move-data
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

FILES=/data/GWAS_data/files/
WORK=/data/GWAS_data/work/
PROCESSED=/processed/
DIRECTORY=

mkdir ${WORK}${DIRECTORY}
chmod go-rwxs ${WORK}${DIRECTORY}
rsync -av "${FILES}${DIRECTORY}${PROCESSED}/" "${WORK}${DIRECTORY}"

chmod g+r ${WORK}${DIRECTORY}
chmod g+r ${WORK}${DIRECTORY}/*
