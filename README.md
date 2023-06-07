# 000_GWAS_formatting

formatting and annotation of publicly available summary statistics:

* `huyghe_2018_PMID30510241/` = [Huyghe et al., (2018)](https://pubmed.ncbi.nlm.nih.gov/30510241/) - colorectal cancer
* `pulit_2019_PMID30239722/` = [Pulit et al., (2019)](https://pubmed.ncbi.nlm.nih.gov/30239722/) - BMI, WHR, WHRadjBMI
* `ferkingstad_2021_PMID34857953/` = [Ferkingstad et al., (2021)](https://pubmed.ncbi.nlm.nih.gov/34857953/) - proteins (somascan)
* `UKB_PPP/` = [(UK Biobank Pharma Proteomics Project)](https://www.biorxiv.org/content/10.1101/2022.06.17.496443v1) - proteins (olink)

base scripts for formatting `scripts/`:
* `convert_gwasvcf_to_ebi.sh` - converts the gwasvcf file format (used by OpenGWAS) to plain text (or what they call EBI format)
* `phenotype_col.sh` - takes the file name and adds a column (at the end) of the GWAS file with the filename in each row - useful when using multiple GWAS
* `make_file_list.sh` - makes a list of filenames and splits them into specified chunks across multiple files called `filelist*` - useful when using lots of GWAS
* `convert_chr-pos_to_rsid.sh` - adds an rsid column to GWAS based on a reference
* `convert_rsid_tochr-pos.sh` - adds a chr and pos column to GWAS based on a reference
