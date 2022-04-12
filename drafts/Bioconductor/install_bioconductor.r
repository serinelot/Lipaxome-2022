################ Codes d'installations pour Bioconductor ##############################

## Site internet : https://www.bioconductor.org/install/

##Librairie 

library(BiocManager)

## Installer  bioconductor

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.11")

## Installer packages de base

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()

## Installer packages spécifiques

BiocManager::install(c("GenomicFeatures", "AnnotationDbi")) #en vert: ex de packages

a#Chercher les packages disponibles

BiocManager::available()

#Identifier les mises à jour disponible pour les packages

BiocManager::install()



