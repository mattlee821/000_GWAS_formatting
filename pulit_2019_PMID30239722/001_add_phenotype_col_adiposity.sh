# add phenotype col to adiposity gwas
cd ~/001_projects/000_datasets/adiposity_GWAS/pulit_EU_2018/
# make phenotype column
tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *.txt; do
    awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : "phenotype")}' "$file" > "$tmp" &&
    mv -- "$tmp" "$file" || exit
done
