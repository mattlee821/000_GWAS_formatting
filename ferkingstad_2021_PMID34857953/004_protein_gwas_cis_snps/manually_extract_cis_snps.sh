export SNP_FILE=/data/protein_GWAS_ferkingstad_EU_2021/work/cis_snp_list.txt
export OUT=${FILE}.unzipped.cis
export WINDOW_CIS=1
export WINDOW_500=500000
export WINDOW_1mb=1000000

export FILE=9754_33_NQO2_Quinone_reductase_2.txt.gz.annotated.gz.exclusions.gz.alleles.gz

gzip -d -c ${FILE} > ${FILE}.unzipped

grep ${FILE}.unzipped $SNP_FILE

export CHR="chr6"
export BP=3003736

# cis
awk -v CHR=$CHR -v BP_pos=$(($BP + $WINDOW_CIS)) -v BP_neg=$(($BP - $WINDOW_CIS)) 'BEGIN{FS=OFS="\t"}FNR==1 || ($1 == CHR && $2 < BP_pos && $2 > BP_neg )' ${FILE}.unzipped > ${FILE}.unzipped.cis
tail -n +2 ${FILE}.unzipped.cis > ${FILE}.unzipped.cis.txt
mv ${FILE}.unzipped.cis.txt cis_snps/

# 500kb
awk -v CHR=$CHR -v BP_pos=$(($BP + $WINDOW_500)) -v BP_neg=$(($BP - $WINDOW_500)) 'BEGIN{FS=OFS="\t"}FNR==1 || ($1 == CHR && $2 < BP_pos && $2 > BP_neg )' ${FILE}.unzipped > ${FILE}.unzipped.cis
tail -n +2 ${FILE}.unzipped.cis > ${FILE}.unzipped.cis.txt
mv ${FILE}.unzipped.cis.txt cis_snps_500k/

# 1mb
awk -v CHR=$CHR -v BP_pos=$(($BP + $WINDOW_1mb)) -v BP_neg=$(($BP - $WINDOW_1mb)) 'BEGIN{FS=OFS="\t"}FNR==1 || ($1 == CHR && $2 < BP_pos && $2 > BP_neg )' ${FILE}.unzipped > ${FILE}.unzipped.cis
tail -n +2 ${FILE}.unzipped.cis > ${FILE}.unzipped.cis.txt
mv ${FILE}.unzipped.cis.txt cis_snps_1mb/

rm ${FILE}.unzipped.cis
rm ${FILE}.unzipped
