# gtex download/format - from: https://github.com/tnieuwe/Matrisome_GTEx_analysis
rm(list=ls())

library(R.utils)
library(tidyverse)
library(DESeq2)
library(data.table)
library(tibble)
library(dplyr)

# load data 
load("/data/GWAS_data/files/references/GTEx/gtex-gene-counts-v8.rda")

gene <- "GREM1"
df_list <- list()

for (i in 1:length(gene)) {
  
  # filter data for genes of interest
  ind <- which(gtab$gene_name%in% gene[i])
  filt_dat <- data.frame(t(dat[ind,]))
  filt_dat <- rownames_to_column(filt_dat, var = "SAMPID")
  filt_dat <- left_join(filt_dat, stab, by = "SAMPID") 
  
  # Assign the dataframe to a list element with variable name based on the gene
  assign(paste0(gene[i]), filt_dat, envir = .GlobalEnv)
  df_list[[i]] <- get(paste0(gene[i]))  # Store the dataframe in the list
}
