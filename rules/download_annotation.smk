rule download_annotation:
    """ Downloads the annotation from Ensembl FTP servers """
    output:
        annotation = config['path']['annotation']
    params:
        link = config['download']['annotation']
    shell:
        "wget -O {output.annotation}.gz {params.link} && "
        "gzip -d {output.annotation}.gz " 


