git clone --recurse-submodules https://github.com/samtools/htslib.git
git clone https://github.com/samtools/bcftools.git
cd bcftools
# The following is optional:
#   autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters
make

export BCFTOOLS_PLUGINS=/home/leem/bcftools/plugins


cd ~/001_projects/000_datasets/adiposity_GWAS/MRCIEU_UKB_BF

bcftools query \
-e 'ID == "."' \
-f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE]\n' \
ukb-b-8909.vcf | \
awk 'BEGIN {print "variant_id\tp_value\tchromosome\tbase_pair_location\teffect_allele\tother_allele\teffect_allele_frequency\tbeta\tstandard_error"}; {OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' > gwas.tsv
