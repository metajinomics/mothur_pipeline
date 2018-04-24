##
#### download mothur
```
wget https://github.com/mothur/mothur/releases/download/v1.40.2/Mothur.linux_64.zip
unzip Mothur.linux_64.zip
```

#### download database
Silva version 132
```
wget https://www.mothur.org/w/images/7/71/Silva.seed_v132.tgz
tar -zxvf Silva.seed_v132.tgz
```
prepare file
```
./mothur/mothur "#pcr.seqs(fasta=silva.seed_v132.align, start=11894, end=25319, keepdots=F, processors=8)"
mv silva.seed_v132.pcr.align silva.v4.fasta
```

RDP trainset version 16
```
wget https://www.mothur.org/w/images/c/c3/Trainset16_022016.pds.tgz
tar -zxvf Trainset16_022016.pds.tgz
```

#### Figure out numbers
make temporary directory 
```
mkdir test
```
then copy one sample of file. For example
```
cp A066MaCpR2_S368_L001_R* test
```
and alignment file
```
cp silva.v4.fasta test
```
now, test run to figure out numbers
```
./mothur/mothur "#make.file(inputdir=test, type=fastq, prefix=stability)"
./mothur/mothur "#make.contigs(inputdir=test, file=stability.files, processors=8)"
./mothur/mothur "#align.seqs(inputdir=test, fasta=stability.trim.contigs.fasta, reference=silva.v4.fasta)"
./mothur/mothur "#summary.seqs(inputdir=test, fasta=test/stability.trim.contigs.align)"
```
Make sure if most of sequences are aligned Start = 1968 and end = 11550, if not, you need to change number in the batch file

#### Finally run mothur
```
./mothur/mothur /mnt/research/germs/softwares/mothur_pipeline/mothur_pipeline_v1.40.2.batch
```

#### your result file will be
```
stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.opti_mcc.shared
stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.opti_mcc.0.03.cons.taxonomy
```
