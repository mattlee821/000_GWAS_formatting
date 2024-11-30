#!/bin/bash

# Convert comma-separated to tab-separated
perl -wnlpi -e 's/,/\t/g;' file

# Convert space-separated (i.e., more than one space) to tab-separated
perl -wnlpi -e 's/\s+/\t/g;' file
