import os

configfile: "config.json"


include: "rules/download_genome.smk"
include: "rules/download_annotation.smk"
include: "rules/download_fastq.smk"
include: "rules/trimming.smk"
include: "rules/qc_trimm.smk"

with open("SRR_id.txt") as f:
    id_list = f.read().splitlines()

id_list = id_list[0:3]

rule all:
    input:
        fastq_file_R1 = expand("data/fastq/{id}_1.fastq", id = id_list),
        fastq_file_R2 = expand("data/fastq/{id}_2.fastq", id = id_list),

        trimm_unpaired_fq1 = expand("data/trimmed/{id}_1.unpaired.fastq.gz", id = id_list),
        trimm_unpaired_fq2 = expand("data/trimmed/{id}_2.unpaired.fastq.gz", id = id_list),

        qc_trimm_fq1_out = expand("data/qc/{id}_1_fastqc.html", id = id_list),

        genome = config['path']['genome'],
        annotation = config['path']['gtf']
