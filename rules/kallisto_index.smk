rule kallisto_index:
    input:
        fasta = config["path"]["genome"]
    output:
        kal_index = "results/kallisto/transcripts.idx",
    log:
        "results/logs/kallisto/index.log",
    conda:
        "../envs/kallisto.yml"
    shell:
        "kallisto index -i {output} {input} 2> {log}"
