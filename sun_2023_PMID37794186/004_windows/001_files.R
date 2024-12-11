rm(list=ls())
set.seed(821)

# environment ====
library(functions)
library(dplyr)
library(stringr)

# VARS ====
base_dir <- "/data/GWAS_data/work/sun_2023_PMID37794186/GWAS/"
output_dir <- "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/004_windows/"
ancestries <- list.dirs(base_dir, full.names = FALSE, recursive = FALSE)

# data ====
data_map <- functions::mapping_GRCh38_p14_olink
for (ancestry in ancestries) {
  # Define the full path to the ancestry directory
  ancestry_dir <- file.path(base_dir, ancestry)
  
  # Create the data frame and process the files
  data <- data.frame(file = list.files(ancestry_dir, 
                                       pattern = "gz", all.files = TRUE, full.names = TRUE)) %>%
    mutate(
      olinkID = str_extract(file, "OID\\d+"), 
      UNIPROT = str_extract(file, "[^_]+(?=_OID\\d+)")  
    ) %>%
    dplyr::left_join(data_map, by = "UNIPROT") %>%
    dplyr::select(file, UNIPROT, CHR, START_hg38, END_hg38)
  
  # Define the output file path
  output_file <- file.path(output_dir, paste0("files_", ancestry, ".txt"))
  
  # Write the data to the output file
  write.table(x = data, file = paste0(output_dir, "files_", ancestry, ".txt"), 
              sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
}
