rule qc_trimm:
    """ Assess the FASTQ quality using FastQC AFTER TRIMMING"""
    input:
        trimm_fq1 = rules.trimming.output.trimm_fq1,
        trimm_fq2 = rules.trimming.output.trimm_fq2,
        trimm_unpaired_fq1 = rules.trimming.output.trimm_unpaired_fq1,
        trimm_unpaired_fq2 = rules.trimming.output.trimm_unpaired_fq2
    
    output:
        qc_trimm_fq1_out = "data/qc_trimmed/{id}_1_fastqc.html",
        qc_trimm_fq2_out = "data/qc_trimmed/{id}_2_fastqc.html"
    
    params:
        out_dir = "data/qc_trimmed"
    
    log:
        "logs/fastqc_trimmed/{id}.log"
    
    threads:
        32
    
    conda:
        "../envs/fastqc.yml"
    
    shell:
        "fastqc "
        "--outdir {params.out_dir} "
        "--format fastq "
        "--threads {threads} "
        "{input.trimm_fq1} {input.trimm_fq2} "
        "{input.trimm_unpaired_fq1} {input.trimm_unpaired_fq2} "
        "&> {log}" 
