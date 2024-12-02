#!/bin/bash

#SBATCH --job-name=download-proteins
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M
#SBATCH --partition=low_p

source activate test_env
cd /data/GWAS_data/files/sun_2023_PMID37794186

synapse get -r syn51364943 
matt821
62533Synapse

mv Metadata docs/
mv SYNAPSE_METADATA_MANIFEST.tsv docs/
mv UKB-PPP\ pGWAS\ summary\ statistics raw/
