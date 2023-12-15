#!/bin/bash

#SBATCH --job-name=download-proteins
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /data/protein_GWAS_ferkingstad_EU_2021/files/raw

wget -i /data/protein_GWAS_ferkingstad_EU_2021/work/urls.txt

for file in * ; do
    mv -v "$file" "${file//download?token=70b20db4-e072-4330-84f1-499fda03b6ae&file#*file=}"
done
