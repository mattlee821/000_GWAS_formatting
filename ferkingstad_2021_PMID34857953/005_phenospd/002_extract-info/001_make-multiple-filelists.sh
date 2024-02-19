# set number of protein files to split ====
# adjust "lines_per_file" based on number of protein files, "wc -l filelist-ferkingstad" + "wc -l filelist-ukb"
cd /data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/
FILE="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/filelist_cis-snps.txt"
lines_per_file=$((($(wc -l < "$FILE") / 99) + 1))
echo $lines_per_file

# split to create the new files  ====
input_file="filelist_cis-snps.txt"
mkdir /data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/filelist/
output_prefix="/data/GWAS_data/work/ferkingstad_2021_PMID34857953/phenospd/filelist/filelist-"
split --lines="$lines_per_file" --numeric-suffixes=1 "$input_file" "$output_prefix"
