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
summary.seqs(fasta=merged.fasta)
unique.seqs(fasta=merged.fasta)

count.seqs(name=merged.names, group=mergegroups)
summary.seqs(count=merged.count_table)

align.seqs(fasta=merged.unique.fasta, reference=/mnt/home/choiji22/dev/darteqm/$gen.fa)




summary.seqs(fasta=merged.unique.align, count=merged.count_table)
screen.seqs(fasta=merged.unique.align, count=merged.count_table, summary=merged.unique.summary, maxhomop=8)
summary.seqs(fasta=current, count=current)
filter.seqs(fasta=merged.unique.good.align, vertical=T, trump=.)

unique.seqs(fasta=merged.unique.good.filter.fasta, count=merged.good.count_table)
pre.cluster(fasta=merged.unique.good.filter.unique.fasta, count=merged.unique.good.filter.count_table, diffs=2)

chimera.vsearch(fasta=merged.unique.good.filter.unique.precluster.fasta, count=merged.unique.good.filter.unique.precluster.count_table, dereplicate=t)
remove.seqs(fasta=merged.unique.good.filter.unique.precluster.fasta, accnos=merged.unique.good.filter.unique.precluster.denovo.vsearch.accnos)

summary.seqs(fasta=current, count=current)


dist.seqs(fasta=merged.unique.good.filter.unique.precluster.pick.fasta, cutoff=0.03)
cluster(column=merged.unique.good.filter.unique.precluster.pick.dist, count=merged.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table)
make.shared(list=merged.unique.good.filter.unique.precluster.pick.opti_mcc.list, count=merged.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, label=0.03)


