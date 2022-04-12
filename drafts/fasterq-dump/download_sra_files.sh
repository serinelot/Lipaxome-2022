#!/bin/bash 
#SBATCH --time=01-00:00:00
#SBATCH --account=def-cakulab  
#SBATCH --mem=32G

while read id
	do
		wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/"$id"/"$id".1
		sleep 1

	done < srr_id.txt
