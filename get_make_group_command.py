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

