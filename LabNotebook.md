
# FastQC Assignment Lab Notebook
## Date: 2024-09-03

### Objective
- Plot Quality scores using FASTQC and python
- Conduct adapter and quality trimming
- Compare final read length distributions
### Methods
Paths for my data files:
```
/projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz
/projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz
/projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz
/projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz
```
- Checked sequence lengths with following shell command:
```
$ zcat <FILE> | sed -
n '2~4p' | awk '{print length}' | sort -n | uniq -c 
```
--> all are 101 bp

### Next Steps
- Set up QAA env
- Start parts 2 and 3
---

## Date: 2024-09-06

### Methods
- Created QAA env with the following command:
```
$ conda create -n "QAA" python=3.12 fastqc=0.12.1 cutadapt=4.9 trimmomatic=0.39
```
- Confirmed correct versions:
```
$ trimmomatic -version
0.39

$ cutadapt --version
4.9

$ fastqc --version
FastQC v0.12.1

$ python --version
Python 3.12.5
```
- Ran the following fastqc commands on each of the assigned fastq files
```
$ /usr/bin/time -v fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz  -o ./out_fastqc/ 
Command being timed: "fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz -o ./out_fastqc/"
        User time (seconds): 163.97
        System time (seconds): 6.84
        Percent of CPU this job got: 97%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 2:55.32
```
```
$ /usr/bin/time -v fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz  -o ./out_fastqc/ 
Command being timed: "fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz -o ./out_fastqc/"
        User time (seconds): 166.99
        System time (seconds): 7.73
        Percent of CPU this job got: 99%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 2:55.96
```
```
$ /usr/bin/time -v fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz -o ./out_fastqc/
Command being timed: "fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz -o ./out_fastqc/"
        User time (seconds): 16.82
        System time (seconds): 0.76
        Percent of CPU this job got: 95%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:18.40
```
```
$ /usr/bin/time -v fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz -o ./out_fastqc/ 
Command being timed: "fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz -o ./out_fastqc/"
        User time (seconds): 17.49
        System time (seconds): 0.82
        Percent of CPU this job got: 93%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:19.50
```

### Next Steps
- Verify adaptors
- Run cutadapt and trimmomatic
---

## Date: 2024-09-07

### Methods
- Ran the following bash commands to verify adapters
```
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz | sed -n '2~4p' | grep --color=always "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | head -n 100
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz | sed -n '2~4p' | grep  --color=always "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | head -n 100
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz | sed -n '2~4p' | grep --color=always "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | head -n 100
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz | sed -n '2~4p' | grep  --color=always "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | head -n 100
```
- Ran Trimmomatic on each paired dataset using sbatch scripts [trimmer_22-3H.sh](./scripts/trimmer_22-3H.sh) and [trimmer_23-4A.sh](./scripts/trimmer_23-4A.sh) with `LEADING:3` `TRAILING:3` `SLIDINGWINDOW:5:15` `MINLEN:35`:
```
TrimmomaticPE: Started with arguments:
 -phred33 -summary trimmerSummary.txt /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz -baseout 22_3H_both_S16_L008.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
Multiple cores found: Using 4 threads
Using templated Output files: 22_3H_both_S16_L008_1P.fastq.gz 22_3H_both_S16_L008_1U.fastq.gz 22_3H_both_S16_L008_2P.fastq.gz 22_3H_both_S16_L008_2U.fastq.gz
Input Read Pairs: 4050899 Both Surviving: 3901597 (96.31%) Forward Only Surviving: 145024 (3.58%) Reverse Only Surviving: 2902 (0.07%) Dropped: 1376 (0.03%)
TrimmomaticPE: Completed successfully
	Command being timed: "trimmomatic PE -phred33 -summary trimmerSummary.txt /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz -baseout 22_3H_both_S16_L008.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35"
	User time (seconds): 197.62
	System time (seconds): 4.22
	Percent of CPU this job got: 211%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:35.50
```
```
TrimmomaticPE: Started with arguments:
 -phred33 -summary trimmerSummary.txt /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz -baseout 23_4A_control_S17_L008.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
Multiple cores found: Using 4 threads
Using templated Output files: 23_4A_control_S17_L008_1P.fastq.gz 23_4A_control_S17_L008_1U.fastq.gz 23_4A_control_S17_L008_2P.fastq.gz 23_4A_control_S17_L008_2U.fastq.gz
Input Read Pairs: 44303262 Both Surviving: 42076142 (94.97%) Forward Only Surviving: 2176303 (4.91%) Reverse Only Surviving: 31859 (0.07%) Dropped: 18958 (0.04%)
TrimmomaticPE: Completed successfully
	Command being timed: "trimmomatic PE -phred33 -summary trimmerSummary.txt /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz -baseout 23_4A_control_S17_L008.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35"
	User time (seconds): 2046.18
	System time (seconds): 42.21
	Percent of CPU this job got: 211%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 16:29.23
```
- Wrote and ran [ldist.py](./scripts/ldist.py) to map trimmed read lengths and ran on each pair of reads
```
$ python scripts/ldist.py -1 ./trimmer_out/22_3H_both_S16_L008_1P.fastq.gz -2 ./trimmer_out/22_3H_both_S16_L008_2P.fastq.gz -p ./ -o 22_3H_both_S16_L008 -t 22_3H_both_S16_L008

$ python scripts/ldist.py -1 ./trimmer_out/23_4A_control_S17_L008_1P.fastq.gz -2 ./trimmer_out/23_4A_control_S17_L008_2P.fastq.gz -p ./ -o 23_4A_control_S17_L008 -t 23_4A_control_S17_L008
```
### Next Steps

---

## Date: 2024-09-08

### Methods
- Installed star, numpy, matplotlib and htseq to my QAA conda environment:
```
$ mamba install star
$ mamba install numpy, matplotlib,htseq

$ STAR --version
2.7.11b
```
```py
###(in python)###
import numpy
import matplotlib
import HTSeq
print(numpy.__version__)
1.26.4 
print(matplotlib.__version__)
3.9.2 
print(HTSeq.__version__)
2.0.5
```
- Downloaded ENSEMBL 112 Mouse Genomes Files:
```
$ wget https://ftp.ensembl.org/pub/release-112/gtf/mus_musculus/Mus_musculus.GRCm39.112.gtf.gz
$ wget https://ftp.ensembl.org/pub/release-112/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
```

- Generated database [Mus_musculus.GRCm39.112.STAR_2.7.11b](./Mus_musculus.GRCm39.112.STAR_2.7.11b/) using [build_database.sh](./scripts/build_database.sh) (adapted from PS8)
- Wrote and ran [align_reads_22-3H.sh](./scripts/align_reads_22-3H.sh) and [align_reads_23-4A.sh](./scripts/align_reads_23-4A.sh) sbatch scripts (adapted from PS8) using 1P and 2P Trimmomatic outputs from each dataset

22-3H
```
Command being timed: "STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn /projects/bgmp/rza/bioinfo/Bi623/QAA/trimmer_out/22_3H_both_S16_L008_1P.fastq.gz /projects/bgmp/rza/bioinfo/Bi623/QAA/trimmer_out/22_3H_both_S16_L008_2P.fastq.gz --genomeDir /projects/bgmp/rza/bioinfo/Bi623/QAA//Mus_musculus.GRCm39.112.STAR_2.7.11b/ --outFileNamePrefix ./aligned/22_3H_both_S16_L008"
	User time (seconds): 190.75
	System time (seconds): 10.52
	Percent of CPU this job got: 395%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:50.88
```
23-4A
```
Command being timed: "STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn /projects/bgmp/rza/bioinfo/Bi623/QAA/trimmer_out/23_4A_control_S17_L008_1P.fastq.gz /projects/bgmp/rza/bioinfo/Bi623/QAA/trimmer_out/23_4A_control_S17_L008_2P.fastq.gz --genomeDir /projects/bgmp/rza/bioinfo/Bi623/QAA//Mus_musculus.GRCm39.112.STAR_2.7.11b/ --outFileNamePrefix ./aligned/23_4A_control_S17_L008"
	User time (seconds): 2226.83
	System time (seconds): 23.35
	Percent of CPU this job got: 697%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:22.50
```
- Ran [mapcount.py](./scripts/mapcount.py) (copied from .../PS8/PS8.py) on each aligned SAM file
```
$ python ./scripts/mapcount.py -f ./aligned/22_3H_both_S16_L008Aligned.out.sam
mapped: 7621872, unmapped: 181322, total: 7803194

$ python ./scripts/mapcount.py -f ./aligned/23_4A_control_S17_L008Aligned.out.sam
mapped: 79158404, unmapped: 4993880, total: 84152284
```
- Submitted sbatch scripts for htseq-count commands
```
Command being timed: "htseq-count --stranded=yes /projects/bgmp/rza/bioinfo/Bi623/QAA/aligned/22_3H_both_S16_L008Aligned.out.sam /projects/bgmp/rza/bioinfo/Bi623/mousedata/Mus_musculus.GRCm39.112.gtf"
	User time (seconds): 341.00
	System time (seconds): 1.54
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:44.82
Command being timed: "htseq-count --stranded=reverse /projects/bgmp/rza/bioinfo/Bi623/QAA/aligned/22_3H_both_S16_L008Aligned.out.sam /projects/bgmp/rza/bioinfo/Bi623/mousedata/Mus_musculus.GRCm39.112.gtf"
	User time (seconds): 346.67
	System time (seconds): 1.33
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:52.63
```
```
Command being timed: "htseq-count --stranded=yes /projects/bgmp/rza/bioinfo/Bi623/QAA/aligned/23_4A_control_S17_L008Aligned.out.sam /projects/bgmp/rza/bioinfo/Bi623/mousedata/Mus_musculus.GRCm39.112.gtf"
	User time (seconds): 3120.67
	System time (seconds): 7.81
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 52:21.11
Command being timed: "htseq-count --stranded=reverse /projects/bgmp/rza/bioinfo/Bi623/QAA/aligned/23_4A_control_S17_L008Aligned.out.sam /projects/bgmp/rza/bioinfo/Bi623/mousedata/Mus_musculus.GRCm39.112.gtf"
	User time (seconds): 3258.24
	System time (seconds): 8.05
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 54:39.89
```
- Summed up htseq counts with the following bash commands:
```
$ cat htseq22-3H_fw.txt | grep -v "__" | awk '{sum+=$2} END {print sum}'
142603
$ cat htseq22-3H_rv.txt | grep -v "__" | awk '{sum+=$2} END {print sum}'
3370858
$ cat htseq22-3H_*.txt | grep -v "__" | awk '{sum+=$2} END {print sum}'
3513461
$ cat htseq22-3H*.txt | awk '{sum += $2} END {print sum}'
7803194

$ cat htseq23-4A_fw.txt | grep -v "__" | awk '{sum += $2} END {print sum}' 
1324268
$ cat htseq23-4A_rv.txt | grep -v "__" | awk '{sum += $2} END {print sum}' 
32827759
$ cat htseq23-4A_*.txt | grep -v "__" | awk '{sum += $2} END {print sum}' 
34152027
$ cat htseq23-4A_*.txt | awk '{sum += $2} END {print sum}'
84152284
```

```
$ python ./scripts/mapcount.py -f ./aligned/22_3H_both_S16_L008Aligned.out.sam
mapped: 7621872, unmapped: 181322, total: 7803194

$ python ./scripts/mapcount.py -f ./aligned/23_4A_control_S17_L008Aligned.out.sam
mapped: 79158404, unmapped: 4993880, total: 84152284
```


---
## Date: 2024-09-08~10

Wrote up lab report, made plots pretty, cleaned up repository, and submitted assignment 

---
# Done

