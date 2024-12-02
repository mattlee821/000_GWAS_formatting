#!/bin/bash

#SBATCH --job-name=move-GWAS
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M
#SBATCH --partition=low_p

FILES=/data/GWAS_data/files/
WORK=/data/GWAS_data/work/
PROCESSED=/processed/
RAW=/raw/
DOCS=/docs/
GWAS=/GWAS/
DIRECTORY=zhang_2022_PMID35501419/

find "${FILES}${DIRECTORY}" -type d -exec chmod 777 {} \;
find "${FILES}${DIRECTORY}" -type f -exec chmod 777 {} \;

# Create destination directories
mkdir -p "${WORK}${DIRECTORY}"
mkdir -p "${WORK}${DIRECTORY}${GWAS}"

# Run rsync and rename files for each directory in parallel
SUBDIRS=("african-american" "european")
for subdir in "${SUBDIRS[@]}"; do
  (
    # Source and destination paths
    SOURCE="${FILES}${DIRECTORY}${PROCESSED}${subdir}/"
    DESTINATION="${WORK}${DIRECTORY}${GWAS}${subdir}/"

    # Ensure the destination directory exists
    mkdir -p "$DESTINATION"

    # Use rsync to copy all files
    rsync -av "$SOURCE" "$DESTINATION"

    # Rename files in the destination directory
    find "$DESTINATION" -type f -name "*.PHENO1.glm.linear" | while read file; do
      mv "$file" "${file/.PHENO1.glm.linear/.txt}"
    done
  ) &
done
wait
echo "File transfer and renaming completed."

# make permissions for work/GWAS
find "${WORK}${DIRECTORY}${GWAS}" -type d -exec chmod 555 {} \;
find "${WORK}${DIRECTORY}${GWAS}" -type f -exec chmod 555 {} \;

# make permissions for files/ user read only
find "${FILES}${DIRECTORY}" -type d -exec chmod 500 {} \;
find "${FILES}${DIRECTORY}" -type f -exec chmod 400 {} \;

# move docs/
mkdir -p ${WORK}${DIRECTORY}
mkdir -p ${WORK}${DIRECTORY}${DOCS}
rsync -av "${FILES}${DIRECTORY}${DOCS}/" "${WORK}${DIRECTORY}${DOCS}"
find "${WORK}${DIRECTORY}${DOCS}" -type d -exec chmod 555 {} \;
find "${WORK}${DIRECTORY}${DOCS}" -type f -exec chmod 555 {} \;

