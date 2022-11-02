# format SNP column in adiposity GWAS

awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.combined.23May2018.txt > bmi_combined.txt
awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.females.23May2018.txt > bmi_females.txt
awk '{sub(/:.*/,"",$3)} 1' bmi.giant-ukbb.meta-analysis.males.23May2018.txt > bmi_males.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.combined.23May2018.txt > whr_combined.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.females.23May2018.txt > whr_females.txt
awk '{sub(/:.*/,"",$3)} 1' whr.giant-ukbb.meta-analysis.males.23May2018.txt > whr_males.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.combined.23May2018.txt > whradjbmi_combined.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.females.23May2018.txt > whradjbmi_females.txt
awk '{sub(/:.*/,"",$3)} 1' whradjbmi.giant-ukbb.meta-analysis.males.23May2018.txt > whradjbmi_males.txt
