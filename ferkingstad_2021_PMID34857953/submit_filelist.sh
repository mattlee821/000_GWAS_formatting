DIRECTORY=/home/leem/001_projects/000_GWAS_formatting/ferkingstad_2021_PMID34857953/003_protein_gwas_alleles/

cd ${DIRECTORY}
# Loop through all .sh files in the directory
for FILE in "${DIRECTORY}"*.sh; do
    if [ -f "$FILE" ]; then
        sbatch "$FILE"
        sleep 5
    fi
done
