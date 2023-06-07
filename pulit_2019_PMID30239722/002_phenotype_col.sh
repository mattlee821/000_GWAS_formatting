# add phenotype col of filename to adiposity gwas
cd /data/GWAS_data/files/pulit_2018_PMID30239722/processed

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *.txt; do
    awk 'BEGIN{OFS=" "} {print $0, (FNR>1 ? FILENAME : "phenotype")}' "$file" > "$tmp" &&
    mv -- "$tmp" "$file" || exit
done
