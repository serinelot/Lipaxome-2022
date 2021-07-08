rule trimming:
    """ Trims the FASTQ files using Trimmomatic """
    input:
        fq1 = rules.download_fastq.output.fastq_file_R1,
        fq2 = rules.download_fastq.output.fastq_file_R2

    output:
        qc_fq1 = "data/trimmed/{id}_1.fastq.gz",
        qc_fq2 = "data/trimmed/{id}_2.fastq.gz",
        unpaired_fq1 = "data/trimmed/{id}_1.unpaired.fastq.gz",
        unpaired_fq2 = "data/trimmed/{id}_2.unpaired.fastq.gz"
    params:
        options = [
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
        "{output.qc_fq1} {output.unpaired_fq1}  "
        "{output.qc_fq2} {output.unpaired_fq2} "
        "{params.options} "
        "&> {log}"