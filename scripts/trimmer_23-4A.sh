#!/usr/bin/env bash

#SBATCH -A bgmp
#SBATCH -p bgmp
#SBATCH -t0-20
#SBATCH -c 8
#SBATCH --output=logs/trimmer23-4A_live_%j.out
#SBATCH --error=logs/trimmer23-4A_live_%j.err
#SBATCH --mail-user=rza@uoregon.edu
#SBATCH --mail-type=ALL

conda activate QAA

/usr/bin/time -v trimmomatic PE -phred33 \
-summary trimmerSummary.txt \
/projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz \
/projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz \
-baseout 23_4A_control_S17_L008.fastq.gz \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:5:15 \
MINLEN:35