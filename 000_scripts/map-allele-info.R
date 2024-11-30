rm(list=ls())
set.seed(821)

# environment ====
library(data.table)
library(dplyr)

LIST_FILES <- list.files("", pattern = "", all.files = T, full.names = T)
#reference data ====
## available here: http://www.haplotype-reference-consortium.org/site (README here ftp://ngs.sanger.ac.uk/production/hrc/HRC.r1-1/README saved as README_HRC)
vcf <- read.table(gzfile("/data/GWAS_data/files/references/HRC.r1-1/HRC.r1-1.GRCh37.wgs.mac5.sites.vcf.gz")) 
## name cols as per file format spec https://samtools.github.io/hts-specs/VCFv4.2.pdf and twosamplemr package
names(vcf)[1:5] <- c("CHR", "POS", "SNP", "REF", "ALT")
# vcf$chr_pos <- paste0(as.character(vcf$CHR),":", as.character(vcf$POS))

# map using SNP====
for (i in 1:length(LIST_FILES)){
  # read
  data <- fread(LIST_FILES[i], header = T)
  # make label
  DATA_OUT <- sub("\\.gz$", ".txt", LIST_FILES[i])
  # join using SNP
  data <- left_join(data, vcf, by = "SNP", relationship = "many-to-many")
  # save
  write.table(data, DATA_OUT, sep = "\t",
              quote = FALSE, row.names = FALSE, col.names = TRUE) 
}
