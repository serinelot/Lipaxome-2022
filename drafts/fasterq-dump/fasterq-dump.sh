#!/bin/bash
#SBATCH --time=02:00:00 
#SBATCH --account=def-cakulab
#SBATCH --mem=32G 

export PATH=/home/serinelo/scratch/sra-tools-2-11/sratoolkit.2.11.0-ubuntu64/bin:$PATH 

fasterq-dump --progress -O ../fastq_GSE102741 $1 
