#!/bin/usr/python
#this script convert fna/qual file into fastq file
#usage: python 454_to_fastq.py sample.fna sample.qual

import sys

from Bio import SeqIO
from Bio.SeqIO.QualityIO import PairedFastaQualIterator
spl = sys.argv[1].split('.')
filename = '_'.join(spl[:-1])+'.fastq'
handle = open(filename, "w") #w=write
records = PairedFastaQualIterator(open(sys.argv[1]), open(sys.argv[2]))
count = SeqIO.write(records, handle, "fastq")
handle.close()
print "Converted %i records" % count
