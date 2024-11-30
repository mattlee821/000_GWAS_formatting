#!/bin/bash

# to convert you need to first download and make bcftools

## make a tools directory in your home space if you dont have one
mkdir ~/tools
cd ~/tools

## download htslib
git clone --recurse-submodules https://github.com/samtools/htslib.git

## download and compile bcftools
git clone https://github.com/samtools/bcftools.git
cd bcftools
### The following is optional:
###   autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters
make


# convert
## change
DATA=
FILE=

## dont change
cd /data/GWAS_data/files/${DATA}/raw/

## run
bcftools query \
-e 'ID == "."' \
-f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE]\n' \
${FILE} | \
awk 'BEGIN {print "SNP\tP\tCHR\tPOS\tEA\tOA\tEAF\tBETA\tSE"}; {OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' > ${FILE}
