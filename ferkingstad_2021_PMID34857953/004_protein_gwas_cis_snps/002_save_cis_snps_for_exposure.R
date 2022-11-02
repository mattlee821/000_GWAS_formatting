rm(list=ls())
## set environment ====
library(dplyr)

# data ====
filenames <- dir("/data/protein_GWAS_ferkingstad_EU_2021/files/cis_snps/", recursive=TRUE, full.names=TRUE, pattern=".txt")
list <- lapply(filenames, function(x) {
  tryCatch(read.table(x, header = F, sep = "\t",
                      col.names = c("CHR", "BP","ID","rsID","A1","A2","BETA", "Pval", "min_log10_pval","SE","N","ImpMAF","phenotype","EffectAllele","OtherAllele","EAF"),
                      colClasses = c("character","numeric","character","character","character","character",
                                     "numeric","numeric","numeric","numeric","numeric","numeric",
                                     "character","character","character","numeric")),
           error=function(e) NULL)
})
data <- bind_rows(list)

data$phenotype <- gsub("/data/protein_GWAS_ferkingstad_EU_2021/files/", "", data$phenotype)
data$phenotype <- gsub(".txt.gz.unzipped", "", data$phenotype)

# save
write.table(data, "data/000_protein_data/exposure_data/cis_snps/cis_snps.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# data ====
filenames <- dir("/data/protein_GWAS_ferkingstad_EU_2021/files/cis_snps_500k/", recursive=TRUE, full.names=TRUE, pattern=".txt")
list <- lapply(filenames, function(x) {
  tryCatch(read.table(x, header = F, sep = "\t",
                      col.names = c("CHR", "BP","ID","rsID","A1","A2","BETA", "Pval", "min_log10_pval","SE","N","ImpMAF","phenotype","EffectAllele","OtherAllele","EAF"),
                      colClasses = c("character","numeric","character","character","character","character",
                                     "numeric","numeric","numeric","numeric","numeric","numeric",
                                     "character","character","character","numeric")),
           error=function(e) NULL)
})
data <- bind_rows(list)

data$phenotype <- gsub("/data/protein_GWAS_ferkingstad_EU_2021/files/", "", data$phenotype)
data$phenotype <- gsub(".txt.gz.unzipped", "", data$phenotype)

# save
write.table(data, "data/000_protein_data/exposure_data/cis_snps/cis_snps_500k.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# data ====
filenames <- dir("/data/protein_GWAS_ferkingstad_EU_2021/files/cis_snps_1mb/", recursive=TRUE, full.names=TRUE, pattern=".txt")
list <- lapply(filenames, function(x) {
  tryCatch(read.table(x, header = F, sep = "\t",
                      col.names = c("CHR", "BP","ID","rsID","A1","A2","BETA", "Pval", "min_log10_pval","SE","N","ImpMAF","phenotype","EffectAllele","OtherAllele","EAF"),
                      colClasses = c("character","numeric","character","character","character","character",
                                     "numeric","numeric","numeric","numeric","numeric","numeric",
                                     "character","character","character","numeric")),
           error=function(e) NULL)
})
data <- bind_rows(list)

data$phenotype <- gsub("/data/protein_GWAS_ferkingstad_EU_2021/files/", "", data$phenotype)
data$phenotype <- gsub(".txt.gz.unzipped", "", data$phenotype)

# save
write.table(data, "data/000_protein_data/exposure_data/cis_snps/cis_snps_1mb.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")



