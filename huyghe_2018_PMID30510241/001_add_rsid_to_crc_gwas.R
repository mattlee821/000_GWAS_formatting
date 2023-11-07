rm(list=ls())

# environment ====
library(data.table)
library(dplyr)

#reference data ====
## Read in SNP ids from VCF file available here: http://www.haplotype-reference-consortium.org/site (README here ftp://ngs.sanger.ac.uk/production/hrc/HRC.r1-1/README saved as README_HRC)
vcf <- read.table(gzfile("/data/GWAS_data/files/references/HRC.r1-1/HRC.r1-1.GRCh37.wgs.mac5.sites.vcf.gz")) 
## name cols as per file format spec https://samtools.github.io/hts-specs/VCFv4.2.pdf and twosamplemr package
names(vcf)[1:5] <- c("chr_name", "chrom_start", "SNP", "REF", "ALT")
## add chr_pos for merge 
vcf$chr_pos <- paste0(as.character(vcf$chr_name),":", as.character(vcf$chrom_start))

# marginal meta ====
file_list <- list.files("/data/GWAS_data/files/huyghe_2018_PMID30510241/processed/", patter = "Marginal", full.names = T)
for (i in 1:length(file_list)){
  data <- fread(file_list[i], header = T)
  data$chr_pos <- paste0(as.character(data$CHR),":", as.character(data$POS))
  colnames(data)[1] <- "SNP_id"
  
  data <- left_join(data, vcf, by = "chr_pos", relationship = "many-to-many")
  
  output_file <- sub("\\.gz$", "", file_list[i])
  write.table(data, output_file, sep = "\t",
              quote = FALSE, row.names = FALSE, col.names = TRUE) 
}

# stratified ====
file_list <- list.files("/data/GWAS_data/files/huyghe_2018_PMID30510241/processed/", patter = "Stratified", full.names = T)
for (i in 1:length(file_list)){
  data <- fread(file_list[i], header = T)
  data$chr_pos <- paste0(as.character(data$CHR),":", as.character(data$POS))
  colnames(data)[1] <- "SNP_id"
  
  data <- left_join(data, vcf, by = "chr_pos", relationship = "many-to-many")
  
  output_file <- sub("\\.gz$", "", file_list[i])
  write.table(data, output_file, sep = "\t",
              quote = FALSE, row.names = FALSE, col.names = TRUE) 
}

# joint ====
file_list <- list.files("/data/GWAS_data/files/huyghe_2018_PMID30510241/processed/", patter = "joint", full.names = T)
for (i in 1:length(file_list)){
  data <- fread(file_list[i], header = T)
  data$chr_pos <- gsub("\\_.*","",data$MarkerName)
  colnames(data)[1] <- "SNP_id"
  
  data <- left_join(data, vcf, by = "chr_pos", relationship = "many-to-many")
  
  output_file <- sub("\\.gz$", "", file_list[i])
  write.table(data, output_file, sep = "\t",
              quote = FALSE, row.names = FALSE, col.names = TRUE) 
}
