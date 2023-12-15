# 000_GWAS_formatting

## how to
1. set-up `/data` directory as `name_year_PMID/`, with sub-directories `raw/`, `processed/`, `docs/` and `/code` directory as `name_year_PMID/` with data specific sub directories
    * `raw/` - contains the data you download
    * `processed/` - contains the formatted data
    * `docs/` - contains the data README etc.
    * `001_download/` - contains code for downloading data
    * `002_standardise/` - contains code for standardising data
    * `003_instruments/` - contains code for identifying instruments for MR
    ```
    DATA=name_year_PMID

    # data 
    mkdir /data/GWAS_data/${DATA}/
    mkdir /data/GWAS_data/${DATA}/raw/
    mkdir /data/GWAS_data/${DATA}/processed/
    mkdir /data/GWAS_data/${DATA}/docs/
    
    # code
    mkdir /data/GWAS_data/work/000_GWAS_data_formatting/${DATA}/
    mkdir /data/GWAS_data/work/000_GWAS_data_formatting/${DATA}/001_download/
    mkdir /data/GWAS_data/work/000_GWAS_data_formatting/${DATA}/002_standardise/
    mkdir /data/GWAS_data/work/000_GWAS_data_formatting/${DATA}/003_instruments/
    ```

2. download data from source to `raw/` - ideally download using a script (e.g., `wget`)
    * for GWAS catalog data you can use [`download_GWAS-catalog.sh`](https://github.com/mattlee821/000_GWAS_formatting/blob/main/scripts/download_GWAS-catalog.sh)
    * save the script in `001_download/`

3. create a `column_mapping_file` using this [template](https://github.com/mattlee821/000_GWAS_formatting/blob/main/scripts/standardise/column_mapping_file)
    * save the `column_mapping_file` in `00*_standardise/`
    * `column_mapping_file` has two columns:
      * column 1 = your column names - you change this column to the names of your columns
      * column 2 = standardised column names - dont change this column, this is what your formatted data will have as column names
    * you dont need to have all of the columns present

4. run `standardise.sh`
    * `standardise.sh` has 4 options:
      * `-i` = this is the name of your GWAS data
      * `-o` = this is where you want to save the formatted data (i.e., `processed/`)
      * `-columns` = the location of the `column_mapping_file` from step 3
      * `-phenotype` = (optional) a string for the phenotype column; if blank, file name is used
    ```
    ${SCRIPT}standardise.sh -i ${DATA_IN} \
    -o ${DATA_OUT} \
    -columns ${DATA_IN}column_mapping_file
    -phenotype trait
    ```

5. if you need to do additional or intermediate steps look at [`scripts/`](https://github.com/mattlee821/000_GWAS_formatting/tree/main/scripts):
    * `convert_gwasvcf_to_ebi.sh` - converts the gwasvcf file format (used by OpenGWAS) to plain text (or what they call EBI format)
    * `phenotype_col.sh` - takes the file name and adds a column (at the end) of the GWAS file with the filename in each row - useful when using multiple GWAS
    * `make_file_list.sh` - makes a list of filenames and splits them into specified chunks across multiple files called `filelist*` - useful when using lots of GWAS
    * `convert_chr-pos_to_rsid.sh` - adds an rsid column to GWAS based on a reference
    * `convert_rsid_to_chr-pos.sh` - adds a chr and pos column to GWAS based on a reference
    * `header.sh` - replaces current header with specified header using delimiter
    * `identify_delimiter.sh` - identifies the most common delimiter used in the first row (usually the header)
    * `download_GWAS-catalog.sh` - `wget` script to help download GWAS + README from EBI GWAS catalog

## data
* `agrawal_2022_PMID35773277/` = [Agrawal et al., (2022)](https://www.nature.com/articles/s41467-022-30931-2) - abdominal/subcutaneous/visceral adiposity measures
* `CRC_early-onset/` = unpublished - colorectal cancer (early onset)
* `fernandez-rozadilla_2022_PMID36539618` = [Fernandez-rozadilla et al., (2022)](https://pubmed.ncbi.nlm.nih.gov/36539618/) - colorectal cancer
* `ferkingstad_2021_PMID34857953/` = [Ferkingstad et al., (2021)](https://pubmed.ncbi.nlm.nih.gov/34857953/) - proteins (somascan)
* `GTEx/` = [Genotype Tissue Expression project](https://gtexportal.org/home/) - tissue expression
* `huyghe_2018_PMID30510241/` = [Huyghe et al., (2018)](https://pubmed.ncbi.nlm.nih.gov/30510241/) - colorectal cancer + subtypes
* `liu_2021_PMID34128465/` = [Liu et al., (2021)](https://pubmed.ncbi.nlm.nih.gov/34128465/) - visceral/subcutaneous/liver/pancreas volume/fat/measurement 
* `pulit_2019_PMID30239722/` = [Pulit et al., (2019)](https://pubmed.ncbi.nlm.nih.gov/30239722/) - BMI, WHR, WHRadjBMI
* `UKB_PPP/` = [UK Biobank Pharma Proteomics Project](https://www.biorxiv.org/content/10.1101/2022.06.17.496443v1) - proteins (olink)
