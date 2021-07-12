rule download_annotation:
    """ Downloads the annotation from Ensembl FTP servers """
    output:
        annotation = config['path']['gtf']
    params:
        link = config['download']['gtf']
    shell:
        "wget -O {output.annotation}.gz {params.link} && "
        "gzip -d {output.annotation}.gz " 


