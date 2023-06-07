# make a list of files and split into equal lists for parallel jobs

ls /data/protein_GWAS_ferkingstad_EU_2021/files/processed/*.gz > filelist

wc -l filelist*

awk 'NR > 250 { exit } NR >= 1 && NR <= 250' filelist > filelist1
awk 'NR > 500 { exit } NR >= 251 && NR <= 500' filelist > filelist2
awk 'NR > 750 { exit } NR >= 501 && NR <= 750' filelist > filelist3
awk 'NR > 1000 { exit } NR >= 751 && NR <= 1000' filelist > filelist4
awk 'NR > 1250 { exit } NR >= 1001 && NR <= 1250' filelist > filelist5
awk 'NR > 1500 { exit } NR >= 1251 && NR <= 1500' filelist > filelist6
awk 'NR > 1750 { exit } NR >= 1501 && NR <= 1750' filelist > filelist7
awk 'NR > 2000 { exit } NR >= 1751 && NR <= 2000' filelist > filelist8
awk 'NR > 2250 { exit } NR >= 2001 && NR <= 2250' filelist > filelist9
awk 'NR > 2500 { exit } NR >= 2251 && NR <= 2500' filelist > filelist10
awk 'NR > 2750 { exit } NR >= 2501 && NR <= 2750' filelist > filelist11
awk 'NR > 3000 { exit } NR >= 2751 && NR <= 3000' filelist > filelist12
awk 'NR > 3250 { exit } NR >= 3001 && NR <= 3250' filelist > filelist13
awk 'NR > 3500 { exit } NR >= 3251 && NR <= 3500' filelist > filelist14
awk 'NR > 3750 { exit } NR >= 3501 && NR <= 3750' filelist > filelist15
awk 'NR > 4000 { exit } NR >= 3751 && NR <= 4000' filelist > filelist16
awk 'NR > 4250 { exit } NR >= 4001 && NR <= 4250' filelist > filelist17
awk 'NR > 4500 { exit } NR >= 4251 && NR <= 4500' filelist > filelist18
awk 'NR > 4750 { exit } NR >= 4501 && NR <= 4750' filelist > filelist19
awk 'NR > 5000 { exit } NR >= 4751 && NR <= 5000' filelist > filelist20

wc -l filelist*