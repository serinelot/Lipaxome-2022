rule download_genome:
    """ Downloads the genome from Ensembl FTP servers """
    output:
        genome = "data/reference/genone.fa"
    params:
        link = config['download']['genome']
    shell:
        "wget --quiet -O {output.genome}.gz {params.link} && "
        "gzip -d {output.genome}.gz "


