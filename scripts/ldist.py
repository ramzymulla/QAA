#!/usr/bin/env python

import argparse as arp
import gzip
import matplotlib.pyplot as plt
import numpy as np

def get_args():
    '''Parses user inputs from command line'''
    parser = arp.ArgumentParser(description="takes in cmd args")    

    parser.add_argument("-p","--filepath", help="defines path to input directory",
                        required=True)               
    parser.add_argument("-1","--file1", help="defines path to file1",
                        required=True)
    parser.add_argument("-2","--file2", help="defines path to file2",
                        required=True)
    parser.add_argument("-o","--baseout", help="defines base for output file name",
                        required=True)
    parser.add_argument("-t", "--title", help="base for figure titles",
                        required=True)
    return parser.parse_args()
args = get_args()

path = args.filepath
fnames = (args.file1,args.file2)
baseout = args.baseout
title = args.title
files = []
ldists = ([0 for i in range(102)],[0 for i in range(102)])

for i,fname in enumerate(fnames):
    if 'gz' in fname:
        f=gzip.open(path+fname,'rt')
    else:
        f=open(path+fname,'r')
    for n,line in enumerate(f):
        if n%4==1:
            l=line.strip()
            ldists[i][len(l)] += 1
    f.close()

xlow = 0
for i in range(len(ldists[0])):
    if ldists[0][i]+ldists[1][i] == 0:
        xlow += 1
    else: break
xlow = (xlow//10)*10 
x_ax = np.arange(len(ldists[0]))
plt.bar(x_ax-0.2,ldists[0],0.4,color="black",label="Read 1")
plt.bar(x_ax+0.2,ldists[1],0.4,color="magenta",label = "Read 2")
plt.xlabel("Read Length (bp)")
plt.ylabel("Frequency")
plt.yscale("log")
plt.xlim(xlow,105)
plt.title(f"{title} Trimmed Read Lengths")
plt.legend()
plt.savefig(f"{baseout}_trimmed_lengths")