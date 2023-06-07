# gtex download/format - from: https://github.com/tnieuwe/Matrisome_GTEx_analysis
rm(list=ls())

library(R.utils)
library(tidyverse)
library(DESeq2)
library(data.table)
library(tibble)
library(dplyr)

### Download the required files from GTEx portal 
## Get reaadcounts of genes
download.file("https://storage.googleapis.com/gtex_analysis_v8/rna_seq_data/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_reads.gct.gz",
              destfile = "/data/GWAS_data/files/references/GTEx/gtex_read_counts.gct.gz")
gunzip("/data/GWAS_data/files/references/GTEx/gtex_read_counts.gct.gz",remove = T)

## Get sample data
stab <- fread("https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt",
              data.table = FALSE)
stab2 <- fread("https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt",
              data.table = FALSE)

## Load in read counts and make gene object
dat <- fread("/data/GWAS_data/files/references/GTEx/gtex_read_counts.gct",data.table = FALSE)
gtab <- dat[,1:2]
colnames(gtab) <- c("gene_id", "gene_name")
dat <- dat[,-1:-2]
rownames(dat) <- gtab$gene_id

## Remove unused samples
stab <- dplyr::filter(.data = stab, SAMPID %in% colnames(dat))
## Make sure samples are in teh same orer as the gtab
ncol(dat) == sum(stab$SAMPID == colnames(dat))

# combine stab2 with stab
stab$SUBJID <- sub("^([^\\-]*\\-[^\\-]*)\\-.*", "\\1", stab$SAMPID)
stab <- left_join(stab, stab2, by = "SUBJID")

## Save data
save(dat, gtab, stab, file = "/data/GWAS_data/files/references/GTEx/gtex-gene-counts-v8.rda")
