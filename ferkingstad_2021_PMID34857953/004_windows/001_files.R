rm(list=ls())
set.seed(821)

# environment ====
library(functions)
library(dplyr)
library(stringr)

# data ====
data_map <- functions::mapping_GRCh38_p14_somalogic
data <- data.frame(file = list.files("/data/GWAS_data/work/ferkingstad_2021_PMID34857953/GWAS/", 
                                     pattern = "gz", all.files = TRUE, full.names = TRUE)) %>%
  dplyr::mutate(SeqId = stringr::str_extract(file, "[0-9]+_[0-9]+") %>%
                  stringr::str_replace("_", "-")) %>% 
  dplyr::left_join(data_map, by = "SeqId") %>%
  dplyr::select(file, UNIPROT, CHR, START_hg38, END_hg38)
write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/ferkingstad_2021_PMID34857953/004_windows/files.txt", 
            sep = "\t", row.names = F, col.names = T, quote = F)
