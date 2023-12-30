rm(list=ls())
set.seed(821)

# environment ====
library(readxl)
library(dplyr)
library(tidyr)
library(data.table)

# files ====
data_files <- fread("/data/GWAS_data/work/UKB_PPP/cis-snps/001_files.txt", header = F)
data_files$ID <- gsub("/data/GWAS_data/work/UKB_PPP/european/", "", data_files$V1)
data_files$ID <- gsub(".gz", "", data_files$ID)

# data: pQTLS discovery (EU) ====
data <- readxl::read_xlsx("/data/GWAS_data/files/UKB_PPP/cis/raw/41586_2023_6592_MOESM3_ESM.xlsx", sheet = 10, skip = 4) # ST9
data <- subset(data, `cis/trans` == "cis")
data <- subset(data, MHC == 0)
data$phenotype <- gsub(":v1", "", data$`UKBPPP ProteinID`)
data$phenotype <- gsub(":", "_", data$phenotype)
data$`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)` <- gsub(":imp:v1", "", data$`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)`)
data <- data %>%
  separate(`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)`, into = c("CHR", "POS", "OA", "EA"), sep = ":", remove = FALSE)
data <- data %>%
  rename(
    SNP = rsID,
    EAF = `A1FREQ (discovery)`,
    BETA = `BETA (discovery, wrt. A1)`,
    SE = `SE (discovery)`,
    P = `log10(p) (discovery)`)
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
               phenotype)
data$N <- 34557
## save 
data <- filter(data, SNP != "-")
write.table(data, "/data/GWAS_data/work/UKB_PPP/cis-snps/002_cissnps-discovery-EU.txt",
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
data <- left_join(data_files, data, by = c("ID" = "phenotype"))
data <- data[complete.cases(data), ]
data$file <- paste0("/data/GWAS_data/work/UKB_PPP/cis-snps/european/", sub(".*/", "", data$V1), ".", data$SNP)
data <- select(data, V1, CHR, POS, file)
data$CHR <- as.numeric(sub("X", 23, data$CHR)) # convert "X" CHR to 23
write.table(data, "/data/GWAS_data/work/UKB_PPP/cis-snps/003_cissnps-discovery-EU_filelist.txt",
            row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

# data: pQTLS combined ====
data <- readxl::read_xlsx("/data/GWAS_data/files/UKB_PPP/cis/raw/41586_2023_6592_MOESM3_ESM.xlsx", sheet = 11, skip = 4) # ST10
data <- subset(data, `cis/trans` == "cis")
data <- subset(data, MHC == 0)
data$phenotype <- gsub(":v1", "", data$`UKBPPP ProteinID`)
data$phenotype <- gsub(":", "_", data$phenotype)
data$`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)` <- gsub(":imp:v1", "", data$`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)`)
data <- data %>%
  separate(`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)`, into = c("CHR", "POS", "OA", "EA"), sep = ":", remove = FALSE)
data <- data %>%
  rename(
    SNP = rsID,
    EAF = A1FREQ,
    BETA = BETA,
    SE = SE,
    P = `log10(p)`)
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
               phenotype)
data$N <- 34557+17806
## save 
data <- filter(data, SNP != "-")
write.table(data, "/data/GWAS_data/work/UKB_PPP/cis-snps/002_cissnps-combined-allancestries.txt",
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
data <- left_join(data_files, data, by = c("ID" = "phenotype"))
data <- data[complete.cases(data), ]
data$file <- paste0("/data/GWAS_data/work/UKB_PPP/cis-snps/combined/", sub(".*/", "", data$V1), ".", data$SNP)
data$V1 <- gsub(pattern = "european", replacement = "combined", x = data$V1)
data <- select(data, V1, CHR, POS, file)
data$CHR <- as.numeric(sub("X", 23, data$CHR)) # convert "X" CHR to 23
write.table(data, "/data/GWAS_data/work/UKB_PPP/cis-snps/003_cissnps-combined-allancestries_filelist.txt",
            row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

# data: pQTLS replication (non-EU) ====
data <- readxl::read_xlsx("/data/GWAS_data/files/UKB_PPP/cis/raw/41586_2023_6592_MOESM3_ESM.xlsx", sheet = 12, skip = 5) # ST11
data <- subset(data, `cis/trans` == "cis")
data <- subset(data, MHC == 0)
data$phenotype <- gsub(":v1", "", data$`UKBPPP ProteinID`)
data$phenotype <- gsub(":", "_", data$phenotype)
data$`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)` <- gsub(":imp:v1", "", data$`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)`)
data <- data %>%
  separate(`Variant ID (CHROM:GENPOS (hg37):A0:A1:imp:v1)`, into = c("CHR", "POS", "OA", "EA"), sep = ":", remove = FALSE)
data <- data %>%
  rename(
    SNP = rsID,
    EAF = A1FREQ,
    BETA = BETA,
    SE = SE,
    P = `log10(p)`,
    ancestry = Ancestry)
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
               ancestry)
data$N <- 17806
## save 
data <- filter(data, SNP != "-")
write.table(data, "/data/GWAS_data/work/UKB_PPP/cis-snps/002_cissnps-replicationn-nonEU.txt",
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
data <- left_join(data_files, data, by = c("ID" = "phenotype"))
data <- data[complete.cases(data), ]
data$file <- paste0("/data/GWAS_data/work/UKB_PPP/cis-snps/non-european/", sub(".*/", "", data$V1), ".", data$SNP)
data$V1 <- gsub(pattern = "european", replacement = "non-european", x = data$V1)
data <- select(data, V1, CHR, POS, file)
data$CHR <- as.numeric(sub("X", 23, data$CHR)) # convert "X" CHR to 23
write.table(data, "/data/GWAS_data/work/UKB_PPP/cis-snps/003_cissnps-replicationn-nonEU_filelist.txt",
            row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
