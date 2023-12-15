rm(list=ls())
set.seed(821)

# environment ====
library(data.table)
library(readxl)
library(tidyr)

# get file names and seqID for joining to cis SNP list ====
data <- read.table("/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/001_files.txt", header = F, sep= "\t", col.names = "FILE")
## Function to process ferkingstad protein names
process_row <- function(row) {
  # Extract everything after the last "/"
  last_slash <- sub(".*/([^/]+)", "\\1", row)
  # Remove specified string
  cleaned_string <- sub("\\.txt\\.gz\\.annotated\\.gz\\.exclusions\\.gz\\.alleles\\.gz$", "", last_slash)
  # Split the cleaned string by the separator "_"
  split_result <- strsplit(cleaned_string, "_")[[1]]
  # Combine the first two items with "_"
  combined_string <- paste(split_result[1:2], collapse = "_")
  return(combined_string)
}
## Apply the function to each row in the dataframe
data$ID <- apply(data, 1, process_row)

# cis-snps
data_snps <- read_xlsx("/data/protein_GWAS_ferkingstad_EU_2021/work/41588_2021_978_MOESM4_ESM.xlsx", sheet = 2, skip = 2)
colnames(data_snps) <- make.names(gsub("\n", "", colnames(data_snps)))
data_snps <- data_snps %>%
  filter(Rank..cond..sign.. == 1) %>%
  filter(Count.Proteins.per.pQTL == 1) %>%
  filter(cis..trans == "cis")
data_snps <- select(data_snps, SeqId, variant)
colnames(data_snps) <- c("ID", "SNP")
data_snps <- data_snps %>%
  separate_rows(SNP, sep = ",")

# combine ====
data <- left_join(data, data_snps, by = "ID")
data <- data[complete.cases(data), ]
data <- select(data, FILE, SNP)
write.table(data, "/data/GWAS_data/work/ferkingstad_2021_PMID34857953/cis-snps/002_filename-cissnps.txt", 
            row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
