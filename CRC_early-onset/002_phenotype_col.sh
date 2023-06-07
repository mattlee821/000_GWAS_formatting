# add phenotype col to crc gwas
cd ~/001_projects/000_datasets/CRC_early-onset/processed
# make phenotype column
tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *annotated.txt; do
awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : "phenotype")}' "$file" > "$tmp" &&
  mv -- "$tmp" "$file" || exit
done
