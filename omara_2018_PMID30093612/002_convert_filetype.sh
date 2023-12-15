# map openGWAS-VCF to GWAS cat format 
cd /data/GWAS_data/files/omara_2018_PMID30093612/raw

DIRECTORY_IN=/data/GWAS_data/files/omara_2018_PMID30093612/raw/

FILE=ebi-a-GCST006464.vcf.gz
/home/leem/tools/bcftools/bcftools query \
-e 'ID == "."' \
-f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE]\n' \
${DIRECTORY_IN}${FILE} | \
awk 'BEGIN {print "variant_id\tp_value\tchromosome\tbase_pair_location\teffect_allele\tother_allele\teffect_allele_frequency\tbeta\tstandard_error"}; {OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' > ${DIRECTORY_IN}${FILE}.txt

FILE=ebi-a-GCST006465.vcf.gz
/home/leem/tools/bcftools/bcftools query \
-e 'ID == "."' \
-f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE]\n' \
${DIRECTORY_IN}${FILE} | \
awk 'BEGIN {print "variant_id\tp_value\tchromosome\tbase_pair_location\teffect_allele\tother_allele\teffect_allele_frequency\tbeta\tstandard_error"}; {OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' > ${DIRECTORY_IN}${FILE}.txt

FILE=ebi-a-GCST006466.vcf.gz
/home/leem/tools/bcftools/bcftools query \
-e 'ID == "."' \
-f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE]\n' \
${DIRECTORY_IN}${FILE} | \
awk 'BEGIN {print "variant_id\tp_value\tchromosome\tbase_pair_location\teffect_allele\tother_allele\teffect_allele_frequency\tbeta\tstandard_error"}; {OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' > ${DIRECTORY_IN}${FILE}.txt

# separate out the endo subset data
awk -F ' ' '{print $1, $2, $3, $5, $6, $7, $8, $9, $10}' ECAC2018_subgroups.txt > ECAC2018_endometrioid.txt
awk -F ' ' '{print $1, $2, $3, $5, $6, $7, $11, $12, $13}' ECAC2018_subgroups.txt > ECAC2018_nonendometrioid.txt
