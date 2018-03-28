
#this command make accnos file 
for x in *.erm;do ../../../envsample/mothur/mothur "#list.seqs(fasta=$x)";done
