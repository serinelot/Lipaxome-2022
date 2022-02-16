rule feature_counts:
    input:
        bam = rules.star_alignReads.output.bam, 
        gtf = "data/references/annotation.gtf"
    output:
        counts = "results/featureCounts/{id}/gene_counts.txt",
        mini_count = "results/featureCounts/{id}/gene_mini_counts.txt"
    params:
        out_dir = "data/featureCounts{id}/"
    log:
        "logs/featureCounts/{id}.log"
    threads:
        32
    conda:
        "../envs/featureCounts.yml"
    shell:
        "featureCounts -T {threads} -t exon -g gene_id -a {input.gtf} -o {output} {input.bam}"
        " 2> {log}"
        "-O {params.out_dir}"
