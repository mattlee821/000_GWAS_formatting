#!/bin/bash

#SBATCH --job-name=download-proteins
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

source activate test_env
cd /data/GWAS_data/files/UKB_PPP

synapse get -r syn51364943 
matt821
62533Synapse
