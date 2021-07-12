rule qc:
    """ Assess the FASTQ quality using FastQC BEFORE TRIMMING"""
    input:
        fq1 = rules.download_fastq.output.fastq_file_R1,
        fq2 = rules.download_fastq.output.fastq_file_R2
    
    output:
        qc_fq1_out = "data/qc/{id}_1_fastqc.html",
        qc_fq2_out = "data/qc/{id}_2_fastqc.html"
    
    params:
        out_dir = "data/qc"
    
    log:
        "logs/fastqc/{id}.log"
    
    threads:
        32
    
    conda:
        "../envs/fastqc.yml"
    
    shell:
        "fastqc "
        "--outdir {params.out_dir} "
        "--format fastq "
        "--threads {threads} "
        "{input.fq1} {input.fq2} "
        "&> {log}" 
