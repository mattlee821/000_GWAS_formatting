import pandas as pd
import gzip
import os
import numpy as np
import sys
sys.path.append('/data/GWAS_data/work/000_GWAS_formatting/000_scripts/standardise')
from save_file_with_retries import save_file_with_retries

# Export ID for consistency in paths
ID = "sun_2023_PMID37794186"
DIRECTORY_ANCESTRY = "test"
VAR1 = "filelist-01"

# map file 
print(f"## Reading mapping file", flush=True)
dtype_dict = {
    'ID': str,
    'REF': str,
    'ALT': str,
    'rsid': str
}
map_file = pd.read_csv(f"/data/GWAS_data/files/{ID}/docs/SNP RSID maps/map_ID-rsid.txt.gz", 
                       sep="\t", 
                       compression="gzip", 
                       dtype=dtype_dict)

# Define file paths using the ID variable
filelist_path = f'/data/GWAS_data/work/000_GWAS_formatting/{ID}/missing/005_standardise/filelist_{DIRECTORY_ANCESTRY}/{VAR1}'

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
      filelist_df = pd.read_csv(f, sep=' ', low_memory=False) 
    
    # merge with mapping file
    print(f"## Merge with mapping file", flush=True)
    filelist_df = pd.merge(filelist_df, map_file, on="ID", how="left")

    print(f"## Make POS col", flush=True)
    filelist_df['POS'] = filelist_df['POS38']
    
    # make P col
    print(f"## Make P cols", flush=True)
    filelist_df['LOG10P'] = pd.to_numeric(filelist_df['LOG10P'], errors='coerce')
    filelist_df['P'] = 10 ** -filelist_df['LOG10P']
    
    # Add phenotype column
    print(f"## Adding phenotype column", flush=True)
    filelist_df['phenotype'] = name_without_extension

    # Select columns
    print(f"## Select cols", flush=True)
    filelist_df = filelist_df[[
        'CHROM',
        'POS',
        'POS19',
        'POS38',
        'rsid',
        'ALLELE1',
        'ALLELE0',
        'A1FREQ',
        'BETA',
        'SE',
        'P',
        'LOG10P',
        'N',
        'INFO',
        'CHISQ',
        'TEST',
        'EXTRA',
        'ID',
        'phenotype'
    ]]

    # Rename columns
    print(f"## Rename cols", flush=True)
    filelist_df = filelist_df.rename(columns={
        'CHROM': 'CHR',
        'rsid': 'SNP',
        'ALLELE1': 'EA',
        'ALLELE0': 'OA',
        'A1FREQ': 'EAF'
    })
    
    # make alleles caps
    print(f"## Formate allele cols", flush=True)
    filelist_df['EA'] = filelist_df['EA'].str.upper()
    filelist_df['OA'] = filelist_df['OA'].str.upper()

    # Save the processed file
    print(f"## Saving processed file to: {file_path}", flush=True)
    save_file_with_retries(filelist_df, file_path)
        
    print(f"## Processed file saved to {file_path}", flush=True)
