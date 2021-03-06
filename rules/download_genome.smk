rule download_genome:
    """ Downloads the genome from Ensembl FTP servers """
    output:
        genome = config['path']['genome']
    params:
        link = config['download']['genome']
    shell:
        "wget -O {output.genome}.gz {params.link} && "
        "gzip -d {output.genome}.gz " 


