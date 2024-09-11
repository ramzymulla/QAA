#!/usr/bin/env bash

#SBATCH -A bgmp
#SBATCH -p bgmp
#SBATCH -t0-20
#SBATCH --output=logs/qdister_live_%j.out
#SBATCH --error=logs/qdister_live_%j.err
#SBATCH --mail-user=rza@uoregon.edu
#SBATCH --mail-type=ALL

conda activate base

fnames="22_3H_both_S16_L008_R1_001.fastq.gz,
22_3H_both_S16_L008_R2_001.fastq.gz,
23_4A_control_S17_L008_R1_001.fastq.gz,
23_4A_control_S17_L008_R2_001.fastq.gz"

for f in $fnames
do
    /usr/bin/time -v python ./scripts/Qplot.py \
-p /projects/bgmp/shared/2017_sequencing/demultiplexed/ \
-f $f \
-o ./out/
done

