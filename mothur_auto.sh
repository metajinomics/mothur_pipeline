gen=$1
cd $gen.folder

#change - in filename into _
for x in *-*;do mv $x ${x%-*}_${x##*-};done


#this command make accnos file 
for x in *.fna;do /mnt/research/germs/softwares/mothur/mothur1.39.5/mothur "#list.seqs(fasta=$x)";done

#this command read fna and accnos then make pick.fna
for x in *.accnos;do /mnt/research/germs/softwares/mothur/mothur1.39.5/mothur "#get.seqs(accnos=$x, fasta=${x%.accnos}.fna)";done

ls -1 *.pick.fna > list.pick

python /mnt/home/choiji22/git/mothur_pipeline/get_make_group_command.py list.pick > group.batch

/mnt/research/germs/softwares/mothur/mothur1.39.5/mothur group.batch


python /mnt/home/choiji22/git/mothur_pipeline/get_merge_file_command.py list.pick > merge.batch
/mnt/research/germs/softwares/mothur/mothur1.39.5/mothur merge.batch 



#from here, run on mothur environment
/mnt/research/germs/softwares/mothur/mothur1.39.5/mothur /mnt/home/choiji22/git/mothur_pipeline/step1.batch
/mnt/research/germs/softwares/mothur/mothur1.39.5/mothur "#align.seqs(fasta=merged.unique.fasta, reference=/mnt/home/choiji22/dev/darteqm/$gen.fa)"
/mnt/research/germs/softwares/mothur/mothur1.39.5/mothur /mnt/home/choiji22/git/mothur_pipeline/step2.batch
