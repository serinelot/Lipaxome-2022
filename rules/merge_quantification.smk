rule merge_quantification:
    input:
        counts = expand("results/featureCounts/{id}_gene_counts.tsv", id = id_list)
    output:
        merged_counts = "data/"
    conda:
        "../envs/r.yml"
    script:
        "../scripts/merge_quant_file.R"
        