import os

configfile: "config.json"

include: "rules/download_fastq.smk"
include: "rules/qc.smk"
include: "rules/trimming.smk"
include: "rules/qc_trimm.smk"
include: "rules/download_genome.smk"
include: "rules/download_annotation.smk"
include: "rules/star_index.smk"
include: "rules/star_alignReads.smk"
include: "rules/feature_counts.smk"
include: "rules/merge_quantification.smk"


with open("SRR_id.txt") as f:
    id_list = f.read().splitlines()

id_list = id_list[0:12]

rule all:
    input:
        merged_counts = "results/merge_quantification/merge_quantif_file.csv"
        # fastq_file_R1 = expand("data/fastq/{id}_1.fastq", id = id_list),
        # fastq_file_R2 = expand("data/fastq/{id}_2.fastq", id = id_list),

        # qc_fq1_out = expand("data/qc/{id}_1_fastqc.html", id = id_list),
        # qc_fq2_out = expand("data/qc/{id}_2_fastqc.html", id = id_list),

        # trimm_unpaired_fq1 = expand("data/trimmed/{id}_1.unpaired.fastq.gz", id = id_list),
        # trimm_unpaired_fq2 = expand("data/trimmed/{id}_2.unpaired.fastq.gz", id = id_list),

        # qc_trimm_fq1_out = expand("data/qc_trimmed/{id}_1_fastqc.html", id = id_list),
        # qc_trimm_fq2_out = expand("data/qc_trimmed/{id}_2_fastqc.html", id = id_list),

        # genome = config['path']['genome'],
        # annotation = config['path']['annotation'],

        # chrNameLength = config['path']['chrNameLength'],

        # bam = expand("results/STAR/{id}/Aligned.sortedByCoord.out.bam", id = id_list),
        # bam_logs = expand("results/STAR/{id}/Log.final.out", id = id_list),

        # counts = expand("results/featureCounts/{id}_gene_counts.tsv", id = id_list),