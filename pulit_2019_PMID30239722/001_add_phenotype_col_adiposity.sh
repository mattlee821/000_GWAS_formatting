# format SNP column
cd ~/001_projects/000_datasets/adiposity_GWAS/pulit_EU_2018/raw/

awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.combined.23May2018.txt > ../processed/bmi_combined.txt
awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.females.23May2018.txt > ../processed/bmi_female.txt
awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.males.23May2018.txt > ../processed/bmi_male.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.combined.23May2018.txt > ../processed/whr_combined.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.females.23May2018.txt > ../processed/whr_female.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.males.23May2018.txt > ../processed/whr_male.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.combined.23May2018.txt > ../processed/whradjbmi_combined.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.females.23May2018.txt > ../processed/whradjbmi_female.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.males.23May2018.txt > ../processed/whradjbmi_male.txt

# add phenotype col of filename to adiposity gwas
cd ~/001_projects/000_datasets/adiposity_GWAS/pulit_EU_2018/processed/

tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *.txt; do
    awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : "phenotype")}' "$file" > "$tmp" &&
    mv -- "$tmp" "$file" || exit
done
