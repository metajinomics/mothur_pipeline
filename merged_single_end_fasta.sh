#change - in filename into _
for x in *-*;do mv $x ${x%-*}_${x##*-};done


#this command make accnos file 
for x in *.fna;do ./mothur/mothur "#list.seqs(fasta=$x)";done

#this command read fna and accnos then make pick.fna
for x in *.accnos;do ./mothur/mothur "#get.seqs(accnos=$x, fasta=${x%.accnos}.fna)";done

ls -1 *.pick.fna > list.pick

python /mnt/home/choiji22/git/mothur_pipeline/get_make_group_command.py list.pick > group.batch

./mothur/mothur group.batch


python /mnt/home/choiji22/git/mothur_pipeline/get_merge_file_command.py list.pick > merge.batch
./mothur/mothur merge.batch 



#from here, run on mothur environment
summary.seqs(fasta=merged.fasta)
unique.seqs(fasta=merged.fasta)

count.seqs(name=merged.names, group=mergegroups)
summary.seqs(count=merged.count_table)
reverse.seqs(fasta=merged.unique.fasta)
align.seqs(fasta=merged.unique.rc.fasta, reference=erm.fa.aln.fa)

summary.seqs(fasta=merged.unique.rc.align, count=merged.count_table)
screen.seqs(fasta=merged.unique.rc.align, count=merged.count_table, summary=merged.unique.rc.summary, start=133, end=425, maxhomop=8)
summary.seqs(fasta=current, count=current)
filter.seqs(fasta=merged.unique.rc.good.align, vertical=T, trump=.)

unique.seqs(fasta=merged.unique.rc.good.filter.fasta, count=merged.good.count_table)
pre.cluster(fasta=merged.unique.rc.good.filter.unique.fasta, count=merged.unique.rc.good.filter.count_table, diffs=2)

chimera.vsearch(fasta=merged.unique.rc.good.filter.unique.precluster.fasta, count=merged.unique.rc.good.filter.unique.precluster.count_table, dereplicate=t)
remove.seqs(fasta=merged.unique.rc.good.filter.unique.precluster.fasta, accnos=merged.unique.rc.good.filter.unique.precluster.denovo.vsearch.accnos)

summary.seqs(fasta=current, count=current)


dist.seqs(fasta=merged.unique.rc.good.filter.unique.precluster.pick.fasta, cutoff=0.03)
cluster(column=merged.unique.rc.good.filter.unique.precluster.pick.dist, count=merged.unique.rc.good.filter.unique.precluster.denovo.vsearch.pick.count_table)
make.shared(list=merged.unique.rc.good.filter.unique.precluster.pick.opti_mcc.list, count=merged.unique.rc.good.filter.unique.precluster.denovo.vsearch.pick.count_table, label=0.03)


