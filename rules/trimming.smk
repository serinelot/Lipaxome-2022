rule trimming:
    """ Trims the FASTQ files using Trimmomatic """
    input:
        fq1 = rules.download_fastq.output.fastq_file_R1,
        fq2 = rules.download_fastq.output.fastq_file_R2

    output:
        trimm_fq1 = "data/trimmed/{id}_1.fastq.gz",
        trimm_fq2 = "data/trimmed/{id}_2.fastq.gz",
        trimm_unpaired_fq1 = "data/trimmed/{id}_1.unpaired.fastq.gz",
        trimm_unpaired_fq2 = "data/trimmed/{id}_2.unpaired.fastq.gz"
    
    params:
        options = [
            "ILLUMINACLIP:data/Adapters-PE_NextSeq.fa:2:30:10",
            "LEADING:5", "TRAILING:5", "MINLEN:45"
        ]
    
    log:
        "logs/trimmomatic/{id}.log"
    
    threads:
        32
    
    conda:
        "../envs/trimmomatic.yml"
    
    shell:
        "trimmomatic PE "
        "-threads {threads} "
        "-phred33 "
        "{input.fq1} {input.fq2} "
        "{output.trimm_fq1} {output.trimm_unpaired_fq1}  "
        "{output.trimm_fq2} {output.trimm_unpaired_fq2} "
        "{params.options} "
        "&> {log}" 