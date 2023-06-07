rm(list=ls())

# environment ====
library(data.table)
library(dplyr)

#reference data ====
## Read in SNP ids from VCF file available here: http://www.haplotype-reference-consortium.org/site (README here ftp://ngs.sanger.ac.uk/production/hrc/HRC.r1-1/README saved as README_HRC)
vcf <- read.table(gzfile("../000_datasets/references/HRC.r1-1.GRCh37.wgs.mac5.sites.vcf.gz")) 
## name cols as per file format spec https://samtools.github.io/hts-specs/VCFv4.2.pdf and twosamplemr package
names(vcf)[1:5] <- c("chr_name", "chrom_start", "SNP", "REF", "ALT")
## add chr_pos for merge 
vcf$chr_pos <- paste0(as.character(vcf$chr_name),":", as.character(vcf$chrom_start))

# crc data ====
# load crc data
crc <- fread("../000_datasets/CRC_early-onset/raw/joint_Early_Onset_wald_MAC50_1.txt")
crc$chr_pos <- gsub("\\_.*","",crc$MarkerName)

## merge using vcf file chr_pos var
data <- left_join(crc, vcf, by = "chr_pos")

## count missing values by column 
sapply(data, function(x) sum(is.na(x)))

## save - a1 = effect allele ====
write.table(data, 
            file = "../000_datasets/CRC_early-onset/processed/joint_Early_Onset_wald_MAC50_1.txt.annotated.txt", 
            quote = FALSE, row.names = FALSE, col.names = TRUE) 
