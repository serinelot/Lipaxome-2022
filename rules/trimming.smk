rule trimming:
    """ Trims the FASTQ files using Trimmomatic """
    input:
        fq1 = "data/fastq/{id}/{id}_1.fastq",
        fq2 = "data/fastq/{id}/{id}_2.fastq"
    output:
        fq1 = "data/trimmed/{id}_1.fastq.gz",
        fq2 = "data/trimmed/{id}_2.fastq.gz",
        unpaired_fq1 = "data/trimmed/{id}_1.unpaired.fastq.gz",
        unpaired_fq2 = "data/trimmed/{id}_2.unpaired.fastq.gz"
    params:
        options = [
            "ILLUMINACLIP:data/Adapters-PE_NextSeq.fa:2:30:10", "LEADING:5",
            "TRAILING:5", "MINLEN:45"
        ]
    log:
        "logs/trimmomatic/{id}.log"
    threads:
        32
    conda:
        "envs/trimmomatic.yaml"
    shell:
        "trimmomatic PE "
        "-threads {threads} "
        "-phred33 "
        "{input.fq1} {input.fq2} "
        "{output.fq1} {output.unpaired_fq1}  "
        "{output.fq2} {output.unpaired_fq2} "
        "{params.options} "
        "&> {log}"