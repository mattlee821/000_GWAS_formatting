# EBI GWAS catalog download

cd /data/GWAS_data/files/

URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/ # change this
STUDY=GCST90016666/ # change this
GWAS=harmonised/34128465-GCST90016666-EFO_0004324.h.tsv.gz # change this
TRAIT=liver-volume # change this
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}
