
# FastQC Assignment Lab Notebook
## Date: 2024-09-03

### Objective

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

---

## Date: 2024-09-07

### Objective

### Methods
- Ran the following bash commands to verify adapters
```
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R1_001.fastq.gz | sed -n '2~4p' | grep --color=always "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | head -n 100
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/22_3H_both_S16_L008_R2_001.fastq.gz | sed -n '2~4p' | grep  --color=always "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | head -n 100
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R1_001.fastq.gz | sed -n '2~4p' | grep --color=always "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | head -n 100
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/23_4A_control_S17_L008_R2_001.fastq.gz | sed -n '2~4p' | grep  --color=always "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | head -n 100
```
### Next Steps

---

## Date: YYYY-MM-DD

### Objective

### Methods

### Next Steps

---

## Date: YYYY-MM-DD

### Objective

### Methods

### Next Steps

---

