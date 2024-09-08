#!/usr/bin/env bash

#SBATCH -A bgmp
#SBATCH -p bgmp
#SBATCH -t0-20
#SBATCH --output=logs/cutadapter_live_%j.out
#SBATCH --error=logs/cutadapter_live_%j.err
#SBATCH --mail-user=rza@uoregon.edu
#SBATCH --mail-type=ALL

conda activate QAA


/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o ./cutadapt_out/22_3H_both_S16_L008_R1_001_trimmed.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz > ./cutadapt_out/bothR1.txt
/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o ./cutadapt_out/22_3H_both_S16_L008_R2_001_trimmed.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz > ./cutadapt_out/bothR2.txt
/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o ./cutadapt_out/23_4A_control_S17_L008_R1_001_trimmed.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz > ./cutadapt_out/contR1.txt
/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o ./cutadapt_out/23_4A_control_S17_L008_R2_001_trimmed.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz > ./cutadapt_out/contR2.txt

