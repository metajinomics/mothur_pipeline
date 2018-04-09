gen=$1
cd $gen.folder

#change - in filename into _
for x in *-*;do mv $x ${x%-*}_${x##*-};done


#this command make accnos file 
for x in *.fna;do ../mothur/mothur "#list.seqs(fasta=$x)";done

#this command read fna and accnos then make pick.fna
for x in *.accnos;do ../mothur/mothur "#get.seqs(accnos=$x, fasta=${x%.accnos}.fna)";done

ls -1 *.pick.fna > list.pick

python /mnt/home/choiji22/git/mothur_pipeline/get_make_group_command.py list.pick > group.batch

../mothur/mothur group.batch


python /mnt/home/choiji22/git/mothur_pipeline/get_merge_file_command.py list.pick > merge.batch
../mothur/mothur merge.batch 



#from here, run on mothur environment
# if functional gene
../mothur/mothur ../mothur_pipeline/step1.batch
../mothur/mothur "#align.seqs(fasta=merged.unique.fasta, reference=/mnt/home/choiji22/dev/darteqm/$gen.fa)"
../mothur/mothur ../mothur_pipeline/step2.batch
