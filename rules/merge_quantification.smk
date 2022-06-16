rule merge_quantification:
    input:
        file_quantif = expand("results/featureCounts/{id}_gene_counts.tsv", id = id_list)
    output:
        merged_counts = "results/merge_quantification/merge_quant_file.csv"
    conda:
        "../envs/R.yml"
    script:
        "../scripts/merge_quant_file.R"
        