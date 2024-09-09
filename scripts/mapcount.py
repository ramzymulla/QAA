#!/usr/bin/env python

import argparse as arp

def get_args():
    '''Parses user inputs from command line'''
    parser = arp.ArgumentParser(description="blah blah blah")                   
    parser.add_argument("-f","--filepath", help="defines path of data file",
                        required=True)
    # parser.add_argument("-t", "--title", help="base for output filenames",
    #                     required=True)
    return parser.parse_args()
args = get_args()

FILE = args.filepath
# TITLE = args.title
SAMCOLS = ['qname','flag','rname','pos','mapq','cigar','rnext','pnext','tlen','seq','qual']
mapped = 0
unmapped = 0
with open(FILE,'r') as f:
    line = f.readline().strip().split()
    while line:
        if line[0][0] !="@":
            data = {i:j for i,j in zip(SAMCOLS,line)}
            flag = int(data['flag'])
            if (flag & 256) != 256:
                if (flag & 4) != 4:
                    mapped +=1
                else:
                    unmapped += 1
                
        line = f.readline().strip().split()
print(f"mapped: {mapped}, unmapped: {unmapped}")

