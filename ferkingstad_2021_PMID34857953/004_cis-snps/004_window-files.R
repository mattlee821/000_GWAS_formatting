rm(list=ls())
set.seed(821)

# environment ====
library(readxl)
library(dplyr)
library(tidyr)
library(data.table)

# files ====
data_files <- fread("/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/001_files.txt", header = F)
data_files$ID <- gsub("/data/GWAS_data/work/ferkingstad_2021_PMID34857953/GWAS/", "", data_files$V1)
data_files$ID <- gsub(".txt.gz.annotated.gz.exclusions.gz.alleles.gz", "", data_files$ID)

# data ====
data <- fread("/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/003_cissnps.txt", col.names = c("CHR","BP","ID","rsID","A1","A2","BETA","Pval","min_log10_pval","SE","N","ImpMAF","phenotype","EffectAllele","OtherAllele","EAF"))
data <- data %>%
  rename(
    SNP = rsID,
    EA = EffectAllele,
    OA = OtherAllele,
    POS = BP,
    P = Pval)
data <- select(data,
               CHR,
               POS,
               SNP,
               EA,
               OA,
               EAF,
               BETA,
               SE,
               P,
               phenotype,
               N)
data$phenotype <- gsub("/data/protein_GWAS_ferkingstad_EU_2021/files/processed/", "", data$phenotype)
data$phenotype <- gsub(".txt.gz.unzipped", "", data$phenotype)
## save 
data <- filter(data, SNP != "-")
write.table(data, "/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/004_cissnps-exposure.txt",
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
data <- left_join(data_files, data, by = c("ID" = "phenotype"))
data <- data[complete.cases(data), ]
data$file <- paste0("/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/window/", sub(".*/", "", data$V1), ".", data$SNP)
data <- select(data, V1, CHR, POS, file)
write.table(data, "/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/005_cissnps_filelist.txt",
            row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
