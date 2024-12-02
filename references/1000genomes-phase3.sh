# based on https://www.cog-genomics.org/plink/2.0/resources#1kg_phase3
# based on https://dougspeed.com/reference-panel/

DIRECTORY_RAW=/data/GWAS_data/files/references/1000genomes/phase3/raw/
DIRECTORY_PROCESSED=/data/GWAS_data/files/references/1000genomes/phase3/processed/

# Download raw files
cd ${DIRECTORY_RAW}
wget https://www.dropbox.com/s/y6ytfoybz48dc0u/all_phase3.pgen.zst
wget https://www.dropbox.com/s/odlexvo8fummcvt/all_phase3.pvar.zst
wget https://www.dropbox.com/s/6ppo144ikdzery5/phase3_corrected.psam
wget https://www.dropbox.com/s/0omyj2tyu7jmmw9/deg1_phase3.king.cutoff.out.id?dl=1
wget https://www.dropbox.com/s/zj8d14vv9mp6x3c/deg2_phase3.king.cutoff.out.id?dl=1
wget https://www.dropbox.com/s/slchsd0uyd4hii8/genetic_map_b37.zip
unzip genetic_map_b37.zip

# rename 
mv phase3_corrected.psam all_phase3.psam
mv deg1_phase3.king.cutoff.out.id?dl=1 deg1_phase3.king.cutoff.out.id
mv deg2_phase3.king.cutoff.out.id?dl=1 deg2_phase3.king.cutoff.out.id

# Use PLINK2 to decompress the pgen and pvar files
~/tools/plink2 --zst-decompress ${DIRECTORY_RAW}all_phase3.pgen.zst > ${DIRECTORY_PROCESSED}all_phase3.pgen
~/tools/plink2 --zst-decompress ${DIRECTORY_RAW}all_phase3.pvar.zst > ${DIRECTORY_PROCESSED}all_phase3.pvar
cp ${DIRECTORY_RAW}all_phase3.psam ${DIRECTORY_PROCESSED}all_phase3.psam

# remove:
## 1st and 2nd degree relateds = 14 (for info: 1s degree is 11)
cd ${DIRECTORY_PROCESSED}
~/tools/plink2 --pfile all_phase3 --remove ${DIRECTORY_RAW}deg2_phase3.king.cutoff.out.id --make-pgen

# Identify super population IDs
awk '{print $5}' ${DIRECTORY_PROCESSED}all_phase3.psam | sort | uniq
awk < ${DIRECTORY_PROCESSED}all_phase3.psam '($5=="AFR"){print 0, $1}' > AFR.keep
awk < ${DIRECTORY_PROCESSED}all_phase3.psam '($5=="AMR"){print 0, $1}' > AMR.keep
awk < ${DIRECTORY_PROCESSED}all_phase3.psam '($5=="EAS"){print 0, $1}' > EAS.keep
awk < ${DIRECTORY_PROCESSED}all_phase3.psam '($5=="EUR"){print 0, $1}' > EUR.keep
awk < ${DIRECTORY_PROCESSED}all_phase3.psam '($5=="SAS"){print 0, $1}' > SAS.keep

# convert to binary PLINK format: 
## restricting to autsomal SNPs with MAF>0.01 
## excluding duplicates 
## excluding SNPs with name "."
SUPER_POPULATION=("AFR" "AMR" "EAS" "EUR" "SAS")
for POPULATION in "${SUPER_POPULATION[@]}"; do
    mkdir -p "${POPULATION}"
    echo "." > exclude.snps
    ~/tools/plink2 --make-bed --out "${POPULATION}/${POPULATION}" \
        --pgen all_phase3.pgen \
        --pvar all_phase3.pvar \
        --psam all_phase3.psam \
        --maf 0.01 \
        --autosome \
        --snps-only just-acgt \
        --max-alleles 2 \
        --rm-dup exclude-all \
        --exclude exclude.snps \
        --keep "${POPULATION}.keep"
done
## we do ALL seperately because we dont exclude anyone
POPULATION=ALL
mkdir ${POPULATION}
echo "." > exclude.snps
~/tools/plink2 --make-bed --out ${POPULATION}/${POPULATION} \
--pgen all_phase3.pgen \
--pvar all_phase3.pvar \
--psam all_phase3.psam \
--maf 0.01 \
--autosome \
--snps-only just-acgt \
--max-alleles 2 \
--rm-dup exclude-all \
--exclude exclude.snps 

# The genotype data will now be stored in binary PLINK format in the files 
# raw.bed, raw.bim and raw.fam. The following commands insert population information 
# and sex into the fam file and replace predictor names with 
# generic names of the form Chr:BP (the latter is not required, 
# but I find this format more convenient). They also save the original names.
SUPER_POPULATION=("AFR" "ALL" "AMR" "EAS" "EUR" "SAS")
for POPULATION in "${SUPER_POPULATION[@]}"; do
    awk '(NR==FNR){arr[$1]=$5"_"$6;ars[$1]=$4;next}{$1=$2;$2=arr[$1];$5=ars[$1];print $0}' all_phase3.psam "${POPULATION}/${POPULATION}.fam" > "${POPULATION}/${POPULATION}_clean.fam"
    mv "${POPULATION}/${POPULATION}_clean.fam" "${POPULATION}/${POPULATION}.fam"
#    awk < "${POPULATION}/${POPULATION}.bim" '{$2=$1":"$4;print $0}' > "${POPULATION}/${POPULATION}_clean.bim"
    awk < "${POPULATION}/${POPULATION}.bim" '{print $1":"$4, $2}' > "${POPULATION}/${POPULATION}.names"
#    mv "${POPULATION}/${POPULATION}_clean.bim" "${POPULATION}/${POPULATION}.bim"
done

# insert genetic distances using PLINK1.9
SUPER_POPULATION=("AFR" "ALL" "AMR" "EAS" "EUR" "SAS")
for POPULATION in "${SUPER_POPULATION[@]}"; do
    ~/tools/plink1.9/plink --bfile "${POPULATION}/${POPULATION}" \
        --cm-map "${DIRECTORY_RAW}genetic_map_b37/genetic_map_chr@_combined_b37.txt" \
        --make-bed \
        --out "${POPULATION}/${POPULATION}_ref"
    mv "${POPULATION}/${POPULATION}_ref.bed" "${POPULATION}/${POPULATION}.bed"
    mv "${POPULATION}/${POPULATION}_ref.bim" "${POPULATION}/${POPULATION}.bim"
    mv "${POPULATION}/${POPULATION}_ref.fam" "${POPULATION}/${POPULATION}.fam"
done

# calculate MAF - we can use this as a rough EAF when not available
SUPER_POPULATION=("AFR" "ALL" "AMR" "EAS" "EUR" "SAS")
for POPULATION in "${SUPER_POPULATION[@]}"; do
	~/tools/ldak5.2.linux --calc-stats "${POPULATION}/"stats --bfile "${POPULATION}/${POPULATION}"
done

# move to work
FILES=/data/GWAS_data/files/
WORK=/data/GWAS_data/work/
PROCESSED=/processed/
mkdir ${WORK}references/1000genomes/
mkdir ${WORK}references/1000genomes/phase3/
DIRECTORY=references/1000genomes/phase3/
SUPER_POPULATION=("AFR" "ALL" "AMR" "EAS" "EUR" "SAS")
for POPULATION in "${SUPER_POPULATION[@]}"; do
    mkdir ${WORK}${DIRECTORY}${POPULATION}
    chmod go-rwxs ${WORK}${DIRECTORY}
    rsync -av --include="*/" --include="*.bed" --include="*.bim" --include="*.fam" --include="stats*" --exclude="*" "${FILES}${DIRECTORY}${PROCESSED}${POPULATION}/" "${WORK}${DIRECTORY}${POPULATION}/"
    chmod g+rx ${WORK}${DIRECTORY}
    chmod g+rx ${WORK}${DIRECTORY}/*
done
