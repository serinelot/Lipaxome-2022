rule download_fastq:
    """ Download FASTQ files from SRR id """
    output:
        # fastq_file_dir = directory("data/fastq/{id}")
        fastq_file_R1 = "data/fastq/{id}_1.fastq",
        fastq_file_R2 = "data/fastq/{id}_2.fastq"

    params:
        srr_id = "{id}",
        output_directory = "data/fastq"

    conda:
        "../envs/sra-tools.yml"

    shell:
        "fasterq-dump --progress -O {params.output_directory} {params.srr_id}" 