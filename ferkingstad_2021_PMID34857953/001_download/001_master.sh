#!/bin/bash

#SBATCH --job-name=download-DECODE
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=5000M
#SBATCH --partition=low_p

cd /data/GWAS_data/work/000_GWAS_formatting/ferkingstad_2021_PMID34857953/001_download/filelist/
OUT=/data/GWAS_data/files/ferkingstad_2021_PMID34857953/raw/

VAR1=

# download
while IFS= read -r URL; do
    # Extract filename from URL
    FILENAME=$(echo "${URL}" | awk -F'=' '{print $NF}')
    
    # Check if the file exists and is not fully downloaded
    if [ -f "${FILENAME}" ]; then
        # Get the remote file size
        REMOTE_SIZE=$(wget --spider --server-response "${URL}" 2>&1 | awk '/Content-Length/ {print $2}' | tr -d '\r')

        # Get the local file size
        LOCAL_SIZE=$(stat -c%s "${FILENAME}")

        # If the local file size is less than the remote file size, delete the file
        if [ "${LOCAL_SIZE}" -lt "${REMOTE_SIZE}" ]; then
            echo "Deleting partially downloaded file ${FILENAME}..."
            rm "${FILENAME}"
        fi
    fi

    # Download the file with the extracted filename
    wget -c "${URL}" -O "${OUT}""${FILENAME}"
done < "${VAR1}"
