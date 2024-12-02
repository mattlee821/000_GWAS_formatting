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
ID = "zhang_2022_PMID35501419"
DIRECTORY_ANCESTRY = "filelist"
VAR1 = "filelist-01"

# Define file paths using the ID variable
filelist_path = f'/data/GWAS_data/work/000_GWAS_formatting/{ID}/002_standardise/002_standardise/filelist_{DIRECTORY_ANCESTRY}/{VAR1}'

# Read the list of files
file_list_df = pd.read_csv(filelist_path, header=None, names=['file_path'])

# Process each file listed in the file list
for index, row in file_list_df.iterrows():
    file_path = row['file_path']  
    # Extract the file name without the extension
    base_name = os.path.basename(file_path)  # Gets the file name with extension
    name_without_extension, _ = os.path.splitext(base_name)  # Removes the extension
    name_without_extension, _ = os.path.splitext(name_without_extension)  # Removes the .txt extension
    name_without_extension, _ = os.path.splitext(name_without_extension)  # Removes the .PHENO1

    print(f"# Processing: {name_without_extension}", flush=True)

    # Read data
    print(f"## Reading file: {file_path}", flush=True)
    filelist_df = pd.read_csv(file_path, sep='\t', comment=None)

    # Strip the '#' character from the first column if present
    print(f"## Removing # from CHR col", flush=True)
    if filelist_df.columns[0].startswith('#'):
        filelist_df.columns = filelist_df.columns.str.lstrip('#')
    # Ensure any data in the first column starting with '#' has it removed
    filelist_df[filelist_df.columns[0]] = filelist_df[filelist_df.columns[0]].astype(str).str.lstrip('#')

    # create OA col
    print(f"## Make A1/A0 cols", flush=True)
    filelist_df['OA'] = np.where(
    filelist_df['A1'] == filelist_df['REF'],  # Condition: A1 matches REF
    filelist_df['ALT'],                       # If true, take the value from ALT
    np.where(
        filelist_df['A1'] == filelist_df['ALT'],  # Condition: A1 matches ALT
        filelist_df['REF'],                       # If true, take the value from REF
        np.nan                                    # If neither condition is met, set OA to NaN
    )
    )

    print(f"## Make POS cols", flush=True)
    filelist_df = convert_coordinates(filelist_df, from_build='hg38', to_build='hg19', chrom_col='CHROM', pos_col='POS')


    # Select columns
    print(f"## Select cols", flush=True)
    filelist_df = filelist_df[[
        'CHROM',
        'POS19',
        'POS38',
        'ID',
        'A1',
        'OA',
        'A1_FREQ',
        'BETA',
        'SE',
        'P',
        'OBS_CT',
        'ERRCODE'
    ]]

    # Rename columns
    print(f"## Rename cols", flush=True)
    filelist_df = filelist_df.rename(columns={
        'CHROM': 'CHR',
        'ID': 'SNP',
        'A1': 'EA',
        'OA': 'OA',
        'A1_FREQ': 'EAF',
        'BETA': 'BETA',
        'SE': 'SE',
        'P': 'P',
        'OBS_CT': 'N',
        'ERRCODE': 'PLINK_ERRCODE'
    })
    
    # Add phenotype column
    print(f"## Adding phenotype column", flush=True)
    filelist_df['phenotype'] = name_without_extension

    # Save the processed file
    print(f"## Saving processed file to: {file_path}", flush=True)
    save_file_with_retries(filelist_df, file_path)
        
    print(f"## Processed file saved to {file_path}", flush=True)
