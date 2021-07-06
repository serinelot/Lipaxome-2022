rule download_fastq:
    """ Download FASTQ files from SRR id """
    output:
        fastq_file_dir = directory("data/fastq/{id}")
        # fastq_file_R1 = "data/fastq/{id}_1.fastq",
        # fastq_file_R2 = "data/fastq/{id}_2.fastq"

    params:
        srr_id = "{id}"

    conda:
        "../envs/sra-tools.yml"

    shell:
        "fasterq-dump -O {output.fastq_file_dir} {params.srr_id}"