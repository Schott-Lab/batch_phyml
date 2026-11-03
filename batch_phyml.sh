#!/bin/bash

#By: Ryan K Schott

# PhyML (https://github.com/stephaneguindon/phyml)
# Requires PhyML to be installed and available in the PATH and as as fasta_header_trim.py and fasta-to-phylip-comb.py in the same folder as batch_phyml.sh
# Companion scripts require biopython to be installed and available in the PATH

for file
do
	echo "Using $file"
	base=$(basename ${file%.*})	
	echo "Using basaname: $base"
	echo "Removing bad characters"
	sed '/^>/! s/N/-/g; s/\!/-/g; /^>/ s/[\.-]/_/g' $file > ${base}_sub.fas
	echo "Trimming fasta headers"
	python fasta_header_trim.py ${base}_sub.fas ${base}_htrim.fas
	sed -i 's/_$//' ${base}_htrim.fas
	echo "Converting to phylip formats"
	python fasta-to-phylip-comb.py ${base}_htrim.fas ${base}_phyml.txt ${base}_paml.txt
	echo "Runing PhyML: GTR+G+I, 5 rate categories, emperical nucleotid freqs, ML estimated ts/tv ratio, "
	phyml -i ${base}_phyml.txt -d nt -m GTR -f e -t e -v e -c 5 -a e
	mv ${base}_phyml.txt_phyml_tree.txt ${base}_phyml.tre
	shift
done
