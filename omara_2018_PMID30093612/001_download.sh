# download
cd /data/GWAS_data/files/omara_2018_PMID30093612/raw

# overall endometrial cancer
wget https://gwas.mrcieu.ac.uk/files/ebi-a-GCST006464/ebi-a-GCST006464.vcf.gz
# endometriod cancer
wget https://gwas.mrcieu.ac.uk/files/ebi-a-GCST006465/ebi-a-GCST006465.vcf.gz
# non-endometrioid cancer
wget https://gwas.mrcieu.ac.uk/files/ebi-a-GCST006466/ebi-a-GCST006466.vcf.gz

# docs
cd /data/GWAS_data/files/omara_2018_PMID30093612/docs
wget https://gwas.mrcieu.ac.uk/files/ebi-a-GCST006464/ebi-a-GCST006464.vcf.gz.tbi
wget https://gwas.mrcieu.ac.uk/files/ebi-a-GCST006465/ebi-a-GCST006465.vcf.gz.tbi
wget https://gwas.mrcieu.ac.uk/files/ebi-a-GCST006466/ebi-a-GCST006466.vcf.gz.tbi

## data excluding UKB was provided by the authors