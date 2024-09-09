#!/bin/bash

#SBATCH -A bgmp
#SBATCH -p bgmp
#SBATCH -c 8
#SBATCH -t 0-20
#SBATCH --output=logs/STAR_align23-4A_%j.out
#SBATCH --error=logs/STAR_align23-4A_%j.err
#SBATCH --mail-user=rza@uoregon.edu
#SBATCH --mail-type=ALL

conda activate QAA
wd="/projects/bgmp/rza/bioinfo/Bi623/QAA/"
file1="trimmer_out/23_4A_control_S17_L008_1P.fastq.gz"
file2="trimmer_out/23_4A_control_S17_L008_2P.fastq.gz"
/usr/bin/time -v STAR \
--runThreadN 8 \
--runMode alignReads \
--outFilterMultimapNmax 3 \
--outSAMunmapped Within KeepPairs \
--alignIntronMax 1000000 \
--alignMatesGapMax 1000000 \
--readFilesCommand zcat \
--readFilesIn ${wd}$file1 ${wd}$file2 \
--genomeDir ${wd}/Mus_musculus.GRCm39.112.STAR_2.7.11b/ \
--outFileNamePrefix ./aligned/23_4A_control_S17_L008