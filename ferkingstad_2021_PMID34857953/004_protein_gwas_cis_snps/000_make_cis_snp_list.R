# get file names and seqID for joining to cis SNP list ====
data <- read.table("data/000_protein_data/exposure_data/filelist.txt", header = F, sep= "\t", col.names = "FILE")
ncols <- max(stringr::str_count(data$FILE, "_")) + 1
colmn <- paste0("col", 1:ncols)
data <-
  tidyr::separate(
    data = data,
    col = FILE,
    sep = "_",
    into = colmn,
    remove = FALSE)
data$sequenceID <- paste0(data$col1, "_", data$col2)
files <- data[,c("FILE", "sequenceID")]

# cis SNP list ====
data <- readxl::read_xlsx("data/000_protein_data/exposure_data/cis_snp_list.xlsx")
data <- left_join(data, files, by = "sequenceID")
a <- data[,7]
write.table(a, "/data/protein_GWAS_ferkingstad_EU_2021/work/filelist_cis_snps.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# save ====
data <- data[complete.cases(data), ]
data$FILE <- paste0(data$FILE, ".unzipped")
write.table(data, "/data/protein_GWAS_ferkingstad_EU_2021/work/cis_snp_list.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

