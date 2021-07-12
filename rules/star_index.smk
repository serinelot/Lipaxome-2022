rule star_index:
    """ Generates the genome index for STAR """
    input:
        fasta = config["path"]["genome"],
        gtf = config["path"]['annotation']
    output:
        chrNameLength = config['path']['chrNameLength']
    params:
        dir = config['path']['star_index']
    log:
        "logs/STAR/index.log"
    conda:
        "../envs/star.yml"
    threads:
        8
    shell:
        "mkdir -p {params.dir} && "
        "STAR --runThreadN {threads} "
        "--runMode genomeGenerate "
        "--genomeDir {params.dir} "
        "--genomeFastaFiles {input.fasta} "
        "--sjdbGTFfile {input.gtf} "
        "--sjdbOverhang 99"
        "&> {log}"

