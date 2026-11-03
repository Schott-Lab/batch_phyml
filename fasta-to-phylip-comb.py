# By: Ryan K Schott
# To be run with the bash script batch_phyml.sh
# Requires biopython to be installed and available in the PATH

from Bio import SeqIO
import sys
import os

records = SeqIO.parse(sys.argv[1], "fasta")
count = SeqIO.write(records, sys.argv[2], "phylip-relaxed")
print("Converted %i records" % count)

from Bio import AlignIO
from Bio.AlignIO.PhylipIO import SequentialPhylipWriter

with open(sys.argv[1], 'r') as input_handle:
    align = AlignIO.read(input_handle, "fasta")
    with open(sys.argv[3], 'w') as output_handle:
        SequentialPhylipWriter(output_handle).write_alignment(align, id_width=52)
