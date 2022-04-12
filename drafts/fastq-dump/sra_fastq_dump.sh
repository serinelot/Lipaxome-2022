#!/bin/bash     
#SBATCH --time=05-00:00:00   
#SBATCH --account=def-cakulab              
#SBATCH --mem=64G  
fastq-dump --split-files $1  