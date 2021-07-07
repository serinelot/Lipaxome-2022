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
        genome = config['path']['genome'],
        annotation = config['path']['gtf'],
        
        fastq_file_dir = expand("data/fastq/{id}", id = id_list)

        # unpaired_fq1 = expand("data/trimmed/{id}_1.unpaired.fastq.gz", id = id_list),
        # unpaired_fq2 = expand("data/trimmed/{id}_2.unpaired.fastq.gz", id = id_list)

        # unpaired_fq1 = expand(rules.trimming.output.unpaired_fq1, id = id_list),
        # unpaired_fq2 = expand(rules.trimming.output.unpaired_fq2, id = id_list)