import os

configfile: "config.json"


include: "rules/download_genome.smk"
include: "rules/download_annotation.smk"
include: "rules/download_fastq.smk"

with open("SRR_id.txt") as f:
    id_list = f.read().splitlines()

id_list = id_list[0:3]

rule all:
    input:
        genome = config['path']['genome'],
        annotation = config['path']['gtf'],

        fastq_file_R1 = expand("data/fastq/{id}_1.fastq", id = id_list),
        fastq_file_R2 = expand("data/fastq/{id}_2.fastq", id = id_list)
    
