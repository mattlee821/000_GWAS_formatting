#!/bin/bash

#SBATCH --job-name=snplist-decode-cis
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=10-10:0:00
#SBATCH --mem=10000M
#SBATCH --partition=low_p

# Define the directory containing your files
directory="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/GWAS/"
# Define the combined output file
output_file="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/SNP-list_DECODE-cis.txt"
# define cis-snp files
awk '{print "/data/GWAS_data/work/ferkingstad_2021_PMID34857953/GWAS/"$NF}' /data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis_snp_list.txt | tail -n +2 > /data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/filelist_cis-snps.txt
FILE="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/filelist_cis-snps.txt"
sed -i 's/\.txt\.gz\.annotated\.gz\.exclusions\.gz\.alleles\.gz\.unzipped/\.txt\.gz\.annotated\.gz\.exclusions\.gz\.alleles\.gz/g' "$FILE"

# extract all SNPs and A0 A1 from 1 GWAS
FILE_IN="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/GWAS/10015_119_KCNAB2_KCAB2.txt.gz.annotated.gz.exclusions.gz.alleles.gz"
FILE_OUT="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/SNP-a0-a1.txt"
zcat "$FILE_IN" | cut -f4-6 > "$FILE_OUT"
zcat "$FILE_IN" | cut -f4-6 | sort -k1 > "$FILE_OUT".sorted
zcat "$FILE_IN" | cut -f4-6 | awk '$1 != "NA"' | sort -k1 > "$FILE_OUT".sorted.NAremoved
