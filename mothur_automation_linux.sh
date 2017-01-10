#change the name of the file from stability.files to whatever suits your study
#read all sequence files, merge
make.contigs(file=stability.files, processors=4)

#remove wrong length
summary.seqs(fasta=stability.trim.contigs.fasta)
screen.seqs(fasta=stability.trim.contigs.fasta, group=stability.contigs.groups, summary=stability.trim.contigs.summary, maxambig=0, maxlength=275)

#remove redundant
unique.seqs(fasta=stability.trim.contigs.good.fasta)

#make count table
count.seqs(name=stability.trim.contigs.good.names, group=stability.contigs.good.groups)

#summary.seqs(count=stability.trim.contigs.good.count_table)

#align sequences to reference - unstable
align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=silva.v4.fasta)

#need to find number
summary.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table)

#remove not-aligned sequences -> make error
screen.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table, summary=stability.trim.contigs.good.unique.summary, start=1968, end=11550, maxhomop=8)

#, processors=1)
#here
#summary.seqs(fasta=current, count=current)
#summary.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table)

#remove overhang?
#filter.seqs(fasta=current, vertical=T, trump=.)
filter.seqs(fasta=stability.trim.contigs.good.unique.good.align, vertical=T, trump=.)

unique.seqs(fasta=current, count=current)
pre.cluster(fasta=current, count=current, diffs=2)
#remove chimera
chimera.uchime(fasta=current, count=current, dereplicate=t)
remove.seqs(fasta=current, accnos=current)
classify.seqs(fasta=current, count=current, reference=trainset14_032015.rdp/trainset9_032012.pds.fasta, taxonomy=trainset14_032015.rdp/trainset9_032012.pds.tax, cutoff=80)
remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota)
remove.groups(count=current, fasta=current, taxonomy=current, groups=Mock)
#this takes long
cluster.split(fasta=current, count=current, taxonomy=current, splitmethod=classify, taxlevel=4, cutoff=0.15)
make.shared(list=current, count=current, label=0.03)
classify.otu(list=current, count=current, taxonomy=current, label=0.03)
phylotype(taxonomy=current)
make.shared(list=current, count=current, label=1)
classify.otu(list=current, count=current, taxonomy=current, label=1)
