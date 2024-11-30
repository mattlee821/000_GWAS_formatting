#!/bin/bash

# set up directories
DATA=name_year_PMID

# data 
mkdir -p /data/GWAS_data/files/${DATA}/
mkdir -p /data/GWAS_data/files/${DATA}/raw/
mkdir -p /data/GWAS_data/files/${DATA}/processed/
mkdir -p /data/GWAS_data/files/${DATA}/docs/

# code
mkdir -p /data/GWAS_data/work/000_GWAS_formatting/${DATA}/
mkdir -p /data/GWAS_data/work/000_GWAS_formatting/${DATA}/001_download/
mkdir -p /data/GWAS_data/work/000_GWAS_formatting/${DATA}/002_standardise/
mkdir -p /data/GWAS_data/work/000_GWAS_formatting/${DATA}/003_instruments/
