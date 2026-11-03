# By: Ryan K Schott
# To be run with the bash script batch_phyml.sh

import sys
import os

#give header index size e.g here first 49 characeters of header will be printed
header_index_upto = 49

with open(sys.argv[2], 'w') as outfile:
    with open(sys.argv[1], 'r') as infile:
        for i in infile.readlines():
            if i[0:1] == '>':
                outfile.write("\n"+i[0:header_index_upto]+"\n")
            
            else:
                outfile.write(i.strip())
            
    outfile.close()
    print("[Done...]")
