#!/usr/bin/env bash

#SBATCH -A bgmp
#SBATCH -p bgmp
#SBATCH -t0-20
#SBATCH --output=logs/htseq22-3H_live_%j.out
#SBATCH --error=logs/htseq22-3H_live_%j.err
#SBATCH --mail-user=rza@uoregon.edu
#SBATCH --mail-type=ALL

conda activate QAA


wd="/projects/bgmp/rza/bioinfo/Bi623/"
file="QAA/aligned/22_3H_both_S16_L008Aligned.out.sam"
gtf="mousedata/Mus_musculus.GRCm39.112.gtf"

/usr/bin/time -v htseq-count --stranded=yes ${wd}$file ${wd}$gtf > htseq22-3H_fw.txt
/usr/bin/time -v htseq-count --stranded=reverse ${wd}$file ${wd}$gtf > htseq22-3H_rv.txt