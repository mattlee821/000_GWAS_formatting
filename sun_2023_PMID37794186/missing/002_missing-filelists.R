rm(list=ls())
set.seed(821)

# environment ====
library(dplyr)

# data_african ====
data <- data.table::fread("/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_african", header = F, sep = "\t", fill = T)
data <- data %>%
  dplyr::filter(V2 != "CHR") %>%
  dplyr::mutate(V1 = paste0("/data/GWAS_data/files/sun_2023_PMID37794186/raw/African/", V1)) %>%
  dplyr::mutate(V1 = gsub(".gz", "", V1)) %>%
  dplyr::select(V1)
# write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_african",
#             sep = "\t", col.names = F, row.names = F)

# data_american ====
data <- data.table::fread("/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_american", header = F, sep = "\t", fill = T)
data <- data %>%
  dplyr::filter(V2 != "CHR") %>%
  dplyr::mutate(V1 = paste0("/data/GWAS_data/files/sun_2023_PMID37794186/raw/American/", V1)) %>%
  dplyr::mutate(V1 = gsub(".gz", "", V1)) %>%
  dplyr::select(V1)
# write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_american", 
#             sep = "\t", col.names = F, row.names = F)

# data_csa ====
data <- data.table::fread("/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_central-south-asian", header = F, sep = "\t", fill = T)
data <- data %>%
  dplyr::filter(V2 != "CHR") %>%
  dplyr::mutate(V1 = paste0("/data/GWAS_data/files/sun_2023_PMID37794186/raw/Central_South Asian/", V1)) %>%
  dplyr::mutate(V1 = gsub(".gz", "", V1)) %>%
  dplyr::select(V1)
# write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_central-south-asian", 
#             sep = "\t", col.names = F, row.names = F)

# data_combined ====
data <- data.table::fread("/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_combined", header = F, sep = "\t", fill = T)
data <- data %>%
  dplyr::filter(V2 != "CHR") %>%
  dplyr::mutate(V1 = paste0("/data/GWAS_data/files/sun_2023_PMID37794186/raw/Combined/", V1)) %>%
  dplyr::mutate(V1 = gsub(".gz", "", V1)) %>%
  dplyr::select(V1)
# write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_combined",
#             sep = "\t", col.names = F, row.names = F)

# data_ea ====
data <- data.table::fread("/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_east-asian", header = F, sep = "\t", fill = T)
data <- data %>%
  dplyr::filter(V2 != "CHR") %>%
  dplyr::mutate(V1 = paste0("/data/GWAS_data/files/sun_2023_PMID37794186/raw/East Asian//", V1)) %>%
  dplyr::mutate(V1 = gsub(".gz", "", V1)) %>%
  dplyr::select(V1)
# write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_east-asian",
#             sep = "\t", col.names = F, row.names = F)

# data_european ====
data <- data.table::fread("/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_european", header = F, sep = "\t", fill = T)
data <- data %>%
  dplyr::filter(V2 != "CHR") %>%
  dplyr::mutate(V1 = paste0("/data/GWAS_data/files/sun_2023_PMID37794186/raw/European (discovery)/", V1)) %>%
  dplyr::mutate(V1 = gsub(".gz", "", V1)) %>%
  dplyr::select(V1)
# write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_european",
#             sep = "\t", col.names = F, row.names = F)

# data_me ====
data <- data.table::fread("/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_middle-east", header = F, sep = "\t", fill = T)
data <- data %>%
  dplyr::filter(V2 != "CHR") %>%
  dplyr::mutate(V1 = paste0("/data/GWAS_data/files/sun_2023_PMID37794186/raw/Middle East/", V1)) %>%
  dplyr::mutate(V1 = gsub(".gz", "", V1)) %>%
  dplyr::select(V1)
# write.table(x = data, file = "/data/GWAS_data/work/000_GWAS_formatting/sun_2023_PMID37794186/missing/filelist_middle-east", 
#             sep = "\t", col.names = F, row.names = F)

