rule kallisto_quant:
    input:
        bam = rules.star_alignReads.output.bam,
        idx = rules.kallisto_index.output.kal_index,
    output:
        directory("results/kallisto/{id}"),
    log:
        "results/logs/kallisto/quant/{id}.log",
    params:
        extra = "",
    conda:
        "../envs/kallisto.yml"
    shell:
        "kallisto quant -i {id} -o {output} "
        "{params.extra} {input.bam} 2> {log}"