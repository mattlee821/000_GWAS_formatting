# format SNP column
cd /data/GWAS_data/files/pulit_2018_PMID30239722/raw/
  
awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.combined.23May2018.txt > ../processed/bmi_combined.txt
awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.females.23May2018.txt > ../processed/bmi_female.txt
awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.males.23May2018.txt > ../processed/bmi_male.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.combined.23May2018.txt > ../processed/whr_combined.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.females.23May2018.txt > ../processed/whr_female.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.males.23May2018.txt > ../processed/whr_male.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.combined.23May2018.txt > ../processed/whradjbmi_combined.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.females.23May2018.txt > ../processed/whradjbmi_female.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.males.23May2018.txt > ../processed/whradjbmi_male.txt
