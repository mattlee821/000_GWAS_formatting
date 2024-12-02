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

# Export ID for consistency in paths
ID = "pietzner_2021_PMID34648354"
DIRECTORY_ANCESTRY = "filelist"
VAR1 = "filelist-01"

# Define file paths using the ID variable
filelist_path = f'/data/GWAS_data/work/000_GWAS_formatting/{ID}/002_standardise/002_standardise/{DIRECTORY_ANCESTRY}/{VAR1}'

# Read the list of files
file_list_df = pd.read_csv(filelist_path, header=None, names=['file_path'])

# Process each file listed in the file list
for index, row in file_list_df.iterrows():
    file_path = row['file_path']  
    # Extract the file name without the extension
    base_name = os.path.basename(file_path)  # Gets the file name with extension
    name_without_extension, _ = os.path.splitext(base_name)  # Removes the extension
    name_without_extension, _ = os.path.splitext(name_without_extension)  # Removes the .txt extension

    print(f"# Processing: {name_without_extension}", flush=True)

    # Read data
    print(f"## Reading file: {file_path}", flush=True)
    with gzip.open(file_path, 'rt') as f:
      filelist_df = pd.read_csv(f, sep='\t')  # Assuming tab-separated values; adjust separator as needed

    # make alleles caps
    print(f"## Make allele caps", flush=True)
    filelist_df['Allele1'] = filelist_df['Allele1'].str.upper()
    filelist_df['Allele2'] = filelist_df['Allele2'].str.upper()

    print(f"## Make POS cols", flush=True)
    filelist_df = convert_coordinates(filelist_df, from_build='hg19', to_build='hg38', chrom_col='chr', pos_col='pos')

    # Select columns
    print(f"## Select cols", flush=True)
    filelist_df = filelist_df[[
        'chr',
        'POS19',
        'POS38',
        'rsid',
        'Allele1',
        'Allele2',
        'Freq1',
        'Effect',
        'StdErr',
        'Pvalue',
        'TotalSampleSize',
        'Direction'
    ]]

    # Rename columns
    filelist_df = filelist_df.rename(columns={
        'chr': 'CHR',
        'rsid': 'SNP',
        'Allele1': 'EA',
        'Allele2': 'OA',
        'Freq1': 'EAF',
        'Effect': 'BETA',
        'StdErr': 'SE',
        'Pvalue': 'P',
        'TotalSampleSize': 'N',
        'Direction': 'METAL_direction'
    })
    
    # Add phenotype column
    print(f"## Adding phenotype column", flush=True)
    filelist_df['phenotype'] = name_without_extension

    # Save the processed file
    print(f"## Saving processed file to: {file_path}", flush=True)
    save_file_with_retries(filelist_df, file_path)
        
    print(f"## Processed file saved to {file_path}", flush=True)
