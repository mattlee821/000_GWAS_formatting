#!/bin/bash

# Usage: ./check_delimiter.sh <FILE>

# title: check delimiter
# description: identify the delimiter used in row 1 and convert that character
# in the whole data frame to tab

FILE="$1"

# Detect the delimiter using the provided AWK script
delimiter=$(awk '
FNR==1 {                          # process the header record
    line=$0                       # duplicate to leave $0 usable
    
    gsub(/[^,|\t]/,"",line)       # remove non-candidates

    split(line,a,"")              # split leftovers

    delete b                      # ... since FNR...
    max=prev=0                    # reset
        
    for(i in a)                   # flip a and count hits
        b[a[i]]++
        
    for(i in b)                   # find max amount of hits
        if(b[i]>=b[max]) {        
            prev=max
            max=i
        }
    if(b[prev]==b[max]) {         # if count collision
        print "Multiple candidates for delimiter. Exiting."
        exit 1
    }
                                  # below: output 
    printf "%s",(max=="\t"?"\\t":(max==" "?"[space]":max))

    exit
}' "$FILE")

if [ "$delimiter" == "\\t" ]; then
    echo "* detected delimiter: tab (\\t)"
elif [ "$delimiter" == "," ]; then
    echo "* detected delimiter: comma (,); converting to tab (\\t)"
    perl -wnlpi -e 's/,/\t/g;' "$FILE"
else
    echo "* delimiter not detected as comma (,) or tab (\\t), assuming it is space and converting to tab"
    perl -wnlpi -e 's/\s+/\t/g;' "$FILE"
fi
