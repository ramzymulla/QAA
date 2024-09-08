#!/usr/bin/env bash

#SBATCH -A bgmp
#SBATCH -p bgmp
#SBATCH -t0-20
#SBATCH -c 8
#SBATCH --output=logs/trimmer22-3H_live_%j.out
#SBATCH --error=logs/trimmer22-3H_live_%j.err
#SBATCH --mail-user=rza@uoregon.edu
#SBATCH --mail-type=ALL

conda activate QAA

/usr/bin/time -v trimmomatic PE -phred33 \
-summary trimmerSummary.txt \
/projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz \
/projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz \
-baseout 22_3H_both_S16_L008.fastq.gz \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:5:15 \
MINLEN:35