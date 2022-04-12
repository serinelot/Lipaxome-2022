#!/bin/bash 
#SBATCH --time=10-00:00:00
#SBATCH --account=def-cakulab  
#SBATCH --mem=32G 

while read id
	do
		gzip  "$id".1_1.fastq "$id".1_2.fastq
		sleep 2
	
	done < srr_id.txt