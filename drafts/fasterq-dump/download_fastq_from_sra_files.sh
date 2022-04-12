while read id
	do
		sbatch fasterq-dump.sh  "$id".1
		sleep 2
	
	done < srr_id.txt