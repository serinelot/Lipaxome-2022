while read id
	do
		sbatch sra_fastq_dump.sh "$id"
		sleep 2
	
	done < sra_id.txt
	