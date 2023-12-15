# map rsid
cat olink_rsid_map_mac5_info03_b0_7_chr1_patched_v2.tsv | head -n 1 > combined.txt
cat olink* | grep -v '^ID' >> combined.txt
