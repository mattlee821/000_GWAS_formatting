# remove # character from header of GWAS files

# crc
cd ~/001_projects/000_datasets/colorectal_cancer/GECCO_125K_GWAS_results
ls *tsv.annotated.txt | while read f; do sed -e '1s/^.//' ${f} > ${f}_with_header.txt; done; # remove comment character from header line
rm *tsv.annotated.txt