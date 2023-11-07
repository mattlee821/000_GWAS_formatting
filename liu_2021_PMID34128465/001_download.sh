# liu GWAS downloads

cd /data/GWAS_data/files/liu_2021_PMID34128465

URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016666/
GWAS=harmonised/34128465-GCST90016666-EFO_0004324.h.tsv.gz
TRAIT=liver-volume
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016667/
GWAS=harmonised/34128465-GCST90016667-EFO_0004324.h.tsv.gz
TRAIT=spleen-volume
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016668/
GWAS=harmonised/34128465-GCST90016668-EFO_0004324.h.tsv.gz
TRAIT=lung-volume
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016669/
GWAS=harmonised/34128465-GCST90016669-EFO_0004324.h.tsv.gz
TRAIT=pancreas-volume
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016670/
GWAS=harmonised/34128465-GCST90016670-EFO_0004324.h.tsv.gz
TRAIT=kidney-volume
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016671/
GWAS=harmonised/34128465-GCST90016671-EFO_0004765.h.tsv.gz
TRAIT=VAT-measurement
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016672/
GWAS=harmonised/34128465-GCST90016672-EFO_0004766.h.tsv.gz
TRAIT=SAT-measurement
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016673/
GWAS=harmonised/34128465-GCST90016673-EFO_0010821.h.tsv.gz
TRAIT=liver-fat-measurement
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}


URL=http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/
README=README.txt
ACCESSION=GCST90016001-GCST90017000/
STUDY=GCST90016675/
GWAS=harmonised/34128465-GCST90016675-EFO_0007800.h.tsv.gz
TRAIT=pancreas-fat-measurement
wget -O docs/README_${TRAIT}.txt ${URL}${ACCESSION}${STUDY}${README}
wget -O raw/${TRAIT}.gz ${URL}${ACCESSION}${STUDY}${GWAS}
