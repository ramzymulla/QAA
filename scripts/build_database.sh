#!/bin/bash

#SBATCH -A bgmp
#SBATCH -p bgmp
#SBATCH -c 8
#SBATCH --mem=100G
#SBATCH -t 0-20
#SBATCH --output=logs/STAR_generate_%j.out
#SBATCH --error=logs/STAR_generate_%j.err
#SBATCH --mail-user=rza@uoregon.edu
#SBATCH --mail-type=ALL

conda activate QAA
wd="/projects/bgmp/rza/bioinfo/Bi623/"
/usr/bin/time -v STAR --runThreadN 8 \
--runMode genomeGenerate \
--genomeDir ${wd}QAA/Mus_musculus.GRCm39.112.STAR_2.7.11b/ \
--genomeFastaFiles ${wd}/mousedata/Mus_musculus.GRCm39.dna.primary_assembly.fa \
--sjdbGTFfile ${wd}/mousedata/Mus_musculus.GRCm39.112.gtf