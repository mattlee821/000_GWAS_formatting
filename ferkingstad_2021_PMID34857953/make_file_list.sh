# make a list of files and split into equal lists for parallel jobs
ls /data/protein_GWAS_ferkingstad_EU_2021/files/*.gz > filelist
wc -l filelist
awk 'NR > 500 { exit } NR >= 1 && NR <= 500' filelist > filelist1
awk 'NR > 1000 { exit } NR >= 501 && NR <= 1000' filelist > filelist2
awk 'NR > 1500 { exit } NR >= 1001 && NR <= 1500' filelist > filelist3
awk 'NR > 2000 { exit } NR >= 1501 && NR <= 2000' filelist > filelist4
awk 'NR > 2500 { exit } NR >= 2001 && NR <= 2500' filelist > filelist5
awk 'NR > 3000 { exit } NR >= 2501 && NR <= 3000' filelist > filelist6
awk 'NR > 3500 { exit } NR >= 3001 && NR <= 3500' filelist > filelist7
awk 'NR > 4000 { exit } NR >= 3501 && NR <= 4000' filelist > filelist8
awk 'NR > 4500 { exit } NR >= 4001 && NR <= 4500' filelist > filelist9
awk 'NR > 5000 { exit } NR >= 4501 && NR <= 5000' filelist > filelist10
wc -l filelist*