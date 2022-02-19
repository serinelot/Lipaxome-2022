rule kallisto_index:
    input:
        fasta = config["path"]["genome"]
    output:
        kal_index = config["path"]["kallisto_index"]
    log:
        "logs/kallisto/index.log" 
    conda:
        "../envs/kallisto.yml"
    threads:
        8
    shell:
        "kallisto index -i {output} {input} 2> {log}"
