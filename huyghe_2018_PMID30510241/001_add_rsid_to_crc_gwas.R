rm(list=ls())

# environment ====
library(data.table)
library(dplyr)

#reference data ====
## Read in SNP ids from VCF file available here: http://www.haplotype-reference-consortium.org/site (README here ftp://ngs.sanger.ac.uk/production/hrc/HRC.r1-1/README saved as README_HRC)
vcf <- read.table(gzfile("../000_datasets/references/references/HRC.r1-1.GRCh37.wgs.mac5.sites.vcf.gz")) 
## name cols as per file format spec https://samtools.github.io/hts-specs/VCFv4.2.pdf and twosamplemr package
names(vcf)[1:5] <- c("chr_name", "chrom_start", "SNP", "REF", "ALT")
## add chr_pos for merge 
vcf$chr_pos <- paste0(as.character(vcf$chr_name),":", as.character(vcf$chrom_start))

# crc data 1 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/MarginalMeta_HRC_EUR_only_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/MarginalMeta_HRC_EUR_only_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 2 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/MarginalMeta_125K_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/MarginalMeta_125K_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 3 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/Stratified_colon_Meta_125K_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/Stratified_colon_Meta_125K_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 4 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/Stratified_distal_Meta_125K_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/Stratified_distal_Meta_125K_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 5 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/Stratified_female_Meta_125K_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/Stratified_female_Meta_125K_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 6 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/Stratified_male_Meta_125K_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/Stratified_male_Meta_125K_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 7 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/Stratified_proximal_Meta_125K_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/Stratified_proximal_Meta_125K_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 8 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/Stratified_rectal_Meta_125K_Results.tsv")
crc$chr_pos <- paste0(as.character(crc$Chr),":", as.character(crc$Position))
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/Stratified_rectal_Meta_125K_Results.tsv.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 9 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_colon_Female_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_colon_Female_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 10 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_distal_Female_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_distal_Female_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 11 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_proximal_Female_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_proximal_Female_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 12 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_rectal_Female_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_rectal_Female_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 13 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_colon_Male_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_colon_Male_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 14 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_distal_Male_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_distal_Male_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 15 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_proximal_Male_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_proximal_Male_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 

# crc data 16 ====
# load crc data
crc <- fread("../000_datasets/huyghe_2018_PMID30510241/raw/joint_rectal_Male_wald_MAC50_1.TBL")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)
colnames(crc)[1] <- "MarkerName"

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
	file = "../000_datasets/huyghe_2018_PMID30510241/processed/joint_rectal_Male_wald_MAC50_1.TBL.annotated.txt", 
	quote = FALSE, row.names = FALSE, col.names = TRUE) 
