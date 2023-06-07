# 000_GWAS_formatting

## how to: general appraoch
1. set-up directory as `name_year_PMID`, with sub-directories `raw/` and `processed/`
2. download data from source to `raw/` - ideally download using a script (e.g., `wget`)
3. identify the delimiter of your file - `scripts/identify_delimiter.sh`
4. make phenotype column - `scripts/phenotype_col.sh`
5. format the header for consistency - `scripts/header.sh`
6. convert file to tab delimiter for consistency - `scripts/convert_delimiter.sh`
7. compress file for storage using `gzip`


## data
* `agrawal_2022_PMID35773277/` = [Agrawal et al., (2022)](https://www.nature.com/articles/s41467-022-30931-2) - abdominal/subcutaneous/visceral adiposity measures
* `CRC_early-onset/` = curently unpublished - colorectal cancer (early onset)
* `ferkingstad_2021_PMID34857953/` = [Ferkingstad et al., (2021)](https://pubmed.ncbi.nlm.nih.gov/34857953/) - proteins (somascan)
* `GTEx/` = [Genotype Tissue Expression project](https://gtexportal.org/home/) - tissue expression
* `huyghe_2018_PMID30510241/` = [Huyghe et al., (2018)](https://pubmed.ncbi.nlm.nih.gov/30510241/) - colorectal cancer
* `liu_2021_PMID34128465/` = [Liu et al., (2021)](https://pubmed.ncbi.nlm.nih.gov/34128465/) - visceral/subcutaneous/liver/pancreas fat 
* `pulit_2019_PMID30239722/` = [Pulit et al., (2019)](https://pubmed.ncbi.nlm.nih.gov/30239722/) - BMI, WHR, WHRadjBMI
* `UKB_PPP/` = [UK Biobank Pharma Proteomics Project](https://www.biorxiv.org/content/10.1101/2022.06.17.496443v1) - proteins (olink)


## `scripts/`:
* `convert_gwasvcf_to_ebi.sh` - converts the gwasvcf file format (used by OpenGWAS) to plain text (or what they call EBI format)
* `phenotype_col.sh` - takes the file name and adds a column (at the end) of the GWAS file with the filename in each row - useful when using multiple GWAS
* `make_file_list.sh` - makes a list of filenames and splits them into specified chunks across multiple files called `filelist*` - useful when using lots of GWAS
* `convert_chr-pos_to_rsid.sh` - adds an rsid column to GWAS based on a reference
* `convert_rsid_tochr-pos.sh` - adds a chr and pos column to GWAS based on a reference
* `header.sh` - replaces current header with specified header using delimiter
* `identify_delimiter.sh` - identifies the most common delimiter used in the first row (usually the header)
