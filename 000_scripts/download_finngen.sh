# to download finngen

# finngen release 10
gsutil ls gs://finngen-public-data-r10/summary_stats/
gsutil cp gs://finngen-public-data-r10/summary_stats/finngen_R10_AB1_ASPERGILLOSIS.gz /data/GWAS_data/files/finngen-r10/

# finngen-UKB
gsutil ls gs://finngen-public-data-r10/ukbb/summary_stats/
gsutil cp gs://finngen-public-data-r10/ukbb/summary_stats/AB1_ASPERGILLOSIS_meta_out.tsv.gz /data/GWAS_data/files/finngen-r10_UKB/
