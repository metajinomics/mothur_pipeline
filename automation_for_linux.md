# Automation for Linux (Ubuntu)

## Before you start
Install mothur
```
wget https://github.com/mothur/mothur/releases/download/v1.39.5/Mothur.linux_64_static.zip
unzip Mothur.linux_64_static.zip
```

If you don't have data, here you can use sample data
```
wget http://www.mothur.org/MiSeqDevelopmentData/StabilityNoMetaG.tar
tar -xvf StabilityNoMetaG.tar
```

If you want small test data, you can download this
```
wget https://www.mothur.org/w/images/d/d6/MiSeqSOPData.zip
unzip MiSeqSOPData.zip
cd MiSeq_SOP/
```

Download database
```
wget https://www.mothur.org/w/images/1/15/Silva.seed_v123.tgz
tar -zxvf Silva.seed_v123.tgz
wget https://www.mothur.org/w/images/6/6c/Trainset14_032015.rdp.tgz
tar -zxvf Trainset14_032015.rdp.tgz
```

get pipeline
```
git clone https://github.com/metajinomics/mothur_pipeline.git
```
Mothur take un-compressed file. so, unzip if your files are compressed.
```
gunzip *.gz
```
make stability file
```
ls *R1*.fastq | cut -f1 -d "_" > groupnames.txt
ls *R1*.fastq > forward.txt
ls *R2*.fastq > reverse.txt
paste groupnames.txt forward.txt > temp.txt
paste temp.txt reverse.txt > stability.files
```
Now, run pipeline
```
./mothur/mothur mothur_pipeline/stability.batch
```
alternatively,
```
./mothur/mothur mothur_pipeline/mothur_automation_linux.sh
```

### Here is the detail
