import os

configfile: "config.json"


include: "rules/download_genome.smk"
include: "rules/download_annotation.smk"

rule all:
    input:
        genome = config['path']['genome'],
        annotation = config['path']['gtf']
    
