import pandas as pd
import gzip
import os
import numpy as np
import sys
import liftover
from liftover import get_lifter
sys.path.append('/data/GWAS_data/work/000_GWAS_formatting/000_scripts/standardise')
from save_file_with_retries import save_file_with_retries
from liftover_function import convert_coordinates

# Define file paths
VAR1 = "filelist-02"
filelist_path = f'/data/GWAS_data/work/000_GWAS_formatting/ferkingstad_2021_PMID34857953/002_standardise/002_standardise/filelist/{VAR1}'
annotated_path = f'/data/GWAS_data/files/ferkingstad_2021_PMID34857953/docs/assocvariants.annotated.txt'
exclusions_path = f'/data/GWAS_data/files/ferkingstad_2021_PMID34857953/docs/assocvariants.excluded.txt'

# Read the list of files
file_list_df = pd.read_csv(filelist_path, header=None, names=['file_path'])

# Read exclusions and annotated files
exclusions_df = pd.read_csv(exclusions_path, sep='\t')
annotated_df = pd.read_csv(annotated_path, sep='\t')  

# Process each file listed in the file list
for index, row in file_list_df.iterrows():
    file_path = row['file_path']  
    # Extract the file name without the extension
    base_name = os.path.basename(file_path)  # Gets the file name with extension
    name_without_extension, _ = os.path.splitext(base_name)  # Removes the extension
    name_without_extension, _ = os.path.splitext(name_without_extension)  # Removes the .txt extension

    print(f"# Processing: {name_without_extension}", flush=True)

    # read data
    print(f"## Reading file: {file_path}", flush=True)
    with gzip.open(file_path, 'rt') as f:
        filelist_df = pd.read_csv(f, sep='\t')  # Assuming tab-separated values; adjust separator as needed
    
    # exclusions step
    print(f"## Excluding rows based on exclusions file: {exclusions_path}", flush=True)
    filelist_df = filelist_df[~filelist_df['Name'].isin(exclusions_df['Name'])]

    # join step
    print(f"## Performing left join with annotated file: {annotated_path}", flush=True)
    filelist_df = pd.merge(filelist_df, annotated_df, on='Name', how='left')

    # POS step
    print(f"## Make POS cols", flush=True)
    filelist_df = convert_coordinates(filelist_df, from_build='hg38', to_build='hg19', chrom_col='Chrom_x', pos_col='Pos_x')

    # select columns
    print(f"## Select cols", flush=True)
    filelist_df = filelist_df[[
        'Chrom_x',
        'rsids_y',
        'POS19',
        'POS38',
        'effectAllele_y',
        'otherAllele_y',
        'effectAlleleFreq',
        'Beta',
        'SE',
        'Pval',
        'minus_log10_pval',
        'N'
    ]]

    # rename columns
    print(f"## Rename cols", flush=True)
    filelist_df = filelist_df.rename(columns={
        'Chrom_x': 'CHR',
        'rsids_y': 'SNP',
        'effectAllele_y': 'EA',
        'otherAllele_y': 'OA',
        'effectAlleleFreq': 'EAF',
        'Beta': 'BETA',
        'SE': 'SE',
        'Pval': 'P',
        'minus_log10_pval': 'Plog10',
        'N': 'N'
    })
    
    # phenotype col
    print(f"## Add phenotype col", flush=True)
    filelist_df['phenotype'] = name_without_extension
    
    # CHR col
    print(f"## Remove chr string from CHR col", flush=True)
    filelist_df['CHR'] = filelist_df['CHR'].str.replace('chr', '', regex=False)

    # write
    print(f"## Saving processed file to: {file_path}", flush=True)
    save_file_with_retries(filelist_df, file_path)
        
    print(f"## Processed file saved to {file_path}", flush=True)
