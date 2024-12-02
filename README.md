# 000_GWAS_formatting

## how to
1. use [`make-directory.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/make-directory.sh)
  - `raw/` is where downloaded data lives
  - `processed/` is where processed data lives (the data you use for stuff)
2. download data to `raw/` =  examples for [GWAS catalog](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/download_GWAScatalog.sh) and [FinnGen](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/download_finngen.sh)
3. use `rsync -av raw/ processed/` to make a copy of the raw GWAS in `processed/`

### standardisation using python (most up-to date)
4. modify [`standardise.py`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise.py) for your specific needs
  - `satndardise.py` relies upon `pandas`, `numpy`, `sqlite`, `gzip`, and `liftover` which you can install with [`conda-env.py`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/conda-env.sh)
  - `standardise.py` depends upon the functions [`save_file_with_retries.py`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/save_file_with_retries.py) and [`liftover_function.py`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/liftover_function.py)
  - in `standardise.py` change:
    - `VAR1` to your downloaded GWAS name
    - `file_path` to the file path for where teh GWAS is 
    - liftover step arguments for your current GWAS build (i.e., hg19 or hg38), the GWAS build you want (i.e., hg19 or hg38), and the name of the chromosome and position columns - position columns will be created with names `POS19` and `POS38`
  - select columns step to the columns you want to keep (examples given)
  - rename columns step to standardized names - your column names are on the left, standard column names on the right
  - CHR col step can be omitted if your chromosome column doesnt have the `chr` string

### standardisation using bash
4. modify [`standardise.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise.sh) for your specific needs
  - `standardise.sh` relies upon a function script of the same name [`standardise.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/standardise.sh) which calls the helper functions in `standardise/`: [check_SNP-column.sh](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/check_SNP-column.sh), [check_archive.sh](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/check_archive.sh), [check_delimiter.sh](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/check_delimiter.sh), [check_phenotype.sh](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/check_phenotype.sh)
    - each of these functions can bd used independentaly
  - `standardise.sh` depends upon a [`column_mapping_file`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/standardise/column_mapping_file) where your columns are on the left and the standardised columns are on the right (example file shown) and 

### helpers
- convert SNPID to rsID using a reference (just a simple left-join): [`convert_SNPID-rsID.R`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/convert_SNPID-rsID.R)
- map allele info using a reference (just a simple left-join): [`map-allele-info.R`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/map-allele-info.R)
- convert delimiters to `\t` using `perl`: [`convert_delimiter.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/convert_delimiter.sh)
- convert GWAS VCF to EBI (i.e., GWAS catalog) file type using `samtools`: [`convert_gwasvcf-ebi.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/convert_gwasvcf-ebi.sh)
- move data from `processed/` to `work/` and change permissions: [`move-processed.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/000_scripts/move-processed.sh)

## examples
- `ferkingstad_2021_PMID34857953/` = [Ferkingstad et al., (2021)](https://pubmed.ncbi.nlm.nih.gov/34857953/) - deCODE proteins (Somalogic)
- `sun_2023_PMID37794186` = [Sun et al., 2023](https://pubmed.ncbi.nlm.nih.gov/37794186/) - UK biobank proteins (Olink)
- `pietzner_2021_PMID34648354` = [Pietzner et al., (2021)](https://pubmed.ncbi.nlm.nih.gov/34648354/) - Fenland proteins (Somalogic)
- `zhang_2022_PMID32424353` = [Zhang et al., (2022)](https://pubmed.ncbi.nlm.nih.gov/35501419/) - ARIC proteins (Somalogic)

## references
- [`1000genomes-phase3.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/references/1000genomes-phase3.sh) downloads and makes 1000 Genomes reference files using the same approach as [doug speed](https://dougspeed.com/reference-panel/)

