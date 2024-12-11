rm(list=ls())
set.seed(821)

# environment ====
library(functions)
library(dplyr)
library(stringr)

# data ====
data_map <- functions::mapping_GRCh38_p14_somalogic
data <- data.table::fread("/data/GWAS_data/work/pietzner_2021_PMID34648354/docs/somamer.mapping.csv") %>%
  dplyr::mutate(file = paste("/data/GWAS_data/work/pietzner_2021_PMID34648354/GWAS/", File, sep = "")) %>%
  dplyr::left_join(data_map, by = c("SomamerID" = "SeqId")) %>%
  dplyr::select(file, UNIPROT, CHR, START_hg38, END_hg38) 
write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/pietzner_2021_PMID34648354/004_windows/files.txt", 
            sep = "\t", row.names = F, col.names = T, quote = F)
