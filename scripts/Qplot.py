#!/usr/bin/env python

import bioinfo  as bi
import gzip
import matplotlib.pyplot as plt
import numpy as np
import argparse as arp

import argparse as arp

def get_args():
    '''Parses user inputs from command line'''
    parser = arp.ArgumentParser(description="get them args")
    parser.add_argument("-p","--filepath", help="defines path of data file",
                        required=True)
    parser.add_argument("-f", "--filenames",help="names of input files (comma separated!)",
                        required=True)
    # parser.add_argument("-t", "--title", help="base for output filenames",
    #                     required=True)
    parser.add_argument("-o", "--outpath",help="path to output directory",
                        required=True)
    return parser.parse_args()

def q_plotter(fname: str, path: str, outpath: str, phred=33):
    '''
    Takes a fastq file and plots the mean Q-score by bp # and Overall Q-score Distribution

    Args:
        fname (str): name of fastq file (if zipped must have "gz"!!!)
        path (str): path to input directory (end in "/"!!!)
        outpath (str): path to output directory (end in "/"!!)
        phred (int, optional): phred encoding. Defaults to 33.
    '''
    recordctr = 0                               # record counter
    qdist = [0 for i in range(43)]              # Q-score counter
    qsums = [0 for i in range(101)]             # per-bp Q-score accumulator

    # open fastq file
    if 'gz' in fname:
        file = gzip.open(path+fname,'rt')
    else:
        file = open(path+fname,'r')
    
    # iterate through file (i starts at 0)
    for i,l in enumerate(file):
        line = l.strip()
        # Q-scores on every 4th line
        if i%4==3:
            lg = len(line)

            # expand qsums if not big enough
            while len(qsums) < lg:
                qsums.append(0)

            for j in range(lg):
                qscore = bi.convert_phred(line[j])
                # expand qdist if not big enough
                while len(qdist) < qscore+1:
                    qdist.append(0)
                qdist[qscore]+=1
                qsums[j] += qscore
            recordctr+=1
    file.close()
    
    q_means = [val/recordctr for val in qsums]
    
    plt.plot(q_means)
    plt.title("Mean Q-Scores by Base Pair #")
    plt.xlabel("Base Pair #")
    plt.ylabel("Mean Q-Score")
    plt.savefig(f"{outpath+fname.split('.')[0]}_qmeans")
    plt.clf()

    plt.bar(list(range(43)),qdist)
    plt.title("Q-score Distribution")
    plt.xlabel("Q-score")
    plt.ylabel("Frequency")
    plt.yscale('log')
    plt.savefig(f"{outpath+fname.split('.')[0]}_qdist")
    plt.clf()

args = get_args()
path = args.filepath
fnames = args.filenames.split(',')
outpath = args.outpath

for f in fnames:
    q_plotter(f,path,outpath)





    
