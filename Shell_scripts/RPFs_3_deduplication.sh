#!/usr/bin/env bash

#This script uses cd-hit-dup to remove PCR duplicates based on the UMIs
#It will output a fastq file with only unique reads
#It then runs fastQC on output to check it is as expected
#-i specifies the fastq input file
#-o specifies the fastq output file
#-e specifies the number of mismatches allowed. By setting to 0 means only unique reads will be kept

#For more info on cd-hit-dup see https://github.com/weizhongli/cdhit/wiki/3.-User's-Guide#cdhitdup
#For some reason you must include the path to the cd-hit-dup program when calling it (even if added to the path)

#read in variables
source common_variables.sh

#read deduplication based on UMIs (4nt at each end of sequence)
for filename in $filenames
do
/home/local/BICR/jwaldron/data/JWALDRON/Scripts/cdhit-master/cdhit-master/cd-hit-auxtools/cd-hit-dup -i $fastq_dir/${filename}_cutadapt.fastq -o $fastq_dir/${filename}_cdhitdup.fastq -e 0
done

#run fastqc on cd-hit-dup output
for filename in $filenames
do
fastqc $fastq_dir/${filename}_cdhitdup.fastq --outdir=$fastqc_dir &
done
wait
