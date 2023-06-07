#!/bin/bash

# from - https://stackoverflow.com/a/64341469

awk '
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
    printf "Delimiter: %s\n",(max=="\t"?"\\t":(max==" "?"[space]":max))

    exit
}' file