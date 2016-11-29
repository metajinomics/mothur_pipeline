#!/usr/bin/python
#this script generate mothur command for make.group using list file

#usage: python get_make_group_command.py listfile > command

import sys
files = []
group = []
for file in open(sys.argv[1],'r'):
    files.append(file.strip())
    spl = file.strip().split('.')
    group.append('.'.join(spl[:-2]))

print "make.group(fasta=" + '-'.join(files)+ ", groups=" + '-'.join(group)+")"
root@howe-iii:/mnt/rock# cat get_merge_file_command.py
#!/usr/bin/python
#this script generate mothur command for make.group using list file

#usage: python get_make_group_command.py listfile > command

import sys
files = []

for file in open(sys.argv[1],'r'):
    files.append(file.strip())

print "merge.files(input=" + '-'.join(files)+ ", output= merged.fasta)"
