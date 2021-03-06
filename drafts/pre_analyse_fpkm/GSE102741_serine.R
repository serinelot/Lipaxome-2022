setwd("C:/Users/serin/OneDrive - USherbrooke/1- UdeS/1-Ma�trise/RNA_chol_gene_asd/Dataset Geo_Omnibus/GSE102741")

library(pheatmap)

library(org.Hs.eg.db)
library(EnsDb.Hsapiens.v86)
keytypes(org.Hs.eg.db)


### Traitement des donn�es de s�quen�age ###

data <- read.csv('GSE102741_log2RPKMcounts.csv',
                 header = TRUE, sep = ";", row.names = 1)

index <- rowSums(data) > 10
#index <- rowSums(data > 0) == ncol(data) 
table(index)
data <- data[index,]

ensIDs <- row.names(data)

cols <- c("SYMBOL")
tempdf <- select(org.Hs.eg.db,
                 keytype = "ENSEMBL",
                 keys = ensIDs,
                 columns = cols)

tempdf <- tempdf[!duplicated(tempdf$ENSEMBL),]

data_log2 <-log2(data)
data_log2[data_log2 == -Inf | data_log2 == "NaN"] <- 0

names(data_log2)[1:39] <- 'Ctrl'
names(data_log2)[40:52] <- 'ASD'


### Set de g�nes FMR1 (codant du pc portable) ###

fmr1.string <- read.csv("C:/Users/serin/OneDrive - USherbrooke/1- UdeS/1-Ma�trise/RNA_chol_gene_asd/Set de g�nes/fmr1_string_interactions.csv"
                        , header = TRUE)


### Convergence du set de g�ne FMR1 dans le dataset ###

idx <- tempdf$SYMBOL %in% fmr1.string$Gene.symbol
table(idx)

data.fmr1 <- data_log2[idx,]                    
dim(data.fmr1)

row.names(data.fmr1) <- tempdf$SYMBOL[which(idx)]

### cluster heatmap fmr1 ### pheatmap() ###

pheatmap(
  data.fmr1
  #,show_rownames=FALSE
)


### PCA FMR1 ### prcomp() ###

pca_fmr1 <- prcomp(t(data.fmr1), scale = T)
plot(pca_fmr1$x[,1], pca_fmr1$x[,2])

pca_fmr1.var <- pca_fmr1$sdev^2
pca_fmr1.var.per <- round(pca_fmr1.var/sum(pca_fmr1.var)*100, 1)

barplot(pca_fmr1.var.per, main="Percent variation for each principal component", xlab="Principal Component", ylab="Percent Variation",
        ylim= range(pretty(c(0, pca_fmr1.var.per))))


### PCA FMR1 ### ggplot2() ###
library(ggplot2)

pca_fmr1.data <- data.frame(Sample=rownames(pca_fmr1$x),
                            X=pca_fmr1$x[,1],
                            Y=pca_fmr1$x[,2])
pca_fmr1.data

ggplot(data=pca_fmr1.data, aes(x = X, y = Y, label = Sample, color = factor(Sample))) +
  geom_text(hjust = 0, nudge_x = 0.2) +
  geom_point() +
  xlab(paste("PC1 - ", pca_fmr1.var.per[1], "%", sep ="")) +
  ylab(paste("PC2 - ", pca_fmr1.var.per[2], "%", sep ="")) +
  theme_bw() +
  ggtitle("Fmr1 PCA Graph - GSE102741")

#Top genes variation

loading_scores <- pca_fmr1$rotation[,1]
gene_scores <- abs(loading_scores) ## get the magnitudes
gene_score_ranked <- sort(gene_scores, decreasing=TRUE)
top_10_genes <- names(gene_score_ranked[1:10])

top_10_genes ## show the names of the top 10 genes
pca_fmr1$rotation[top_10_genes,1] ## show the scores (and +/- sign)

library(data.table)
top_10_genes_fmr1_pca <- pca_fmr1$rotation[top_10_genes,1]
top_10_genes_fmr1_pca <- as.data.frame(top_10_genes_fmr1_pca)

top_10_genes_fmr1_pca <- setDT(top_10_genes_fmr1_pca, keep.rownames = T)[]
colnames(top_10_genes_fmr1_pca) <- c("Genes","Variation")
top_10_genes_fmr1_pca


ggplot(data=top_10_genes_fmr1_pca, aes(x = reorder(Genes, -Variation), y = Variation)) + 
  geom_bar(stat="identity",color = "blue", fill = "gray") + 
  geom_text(aes(label= sprintf("%0.3f",top_10_genes_fmr1_pca$Variation)), vjust=0.5, hjust = -0.2, size=3.5) +
  coord_flip() +
  ggtitle("Top 10 genes associated with FMR1 influencing the PCA graph - GSE102741") +
  labs(x = "Genes", y = "Score")


### Set de g�nes cholest�rol ALL (codant du pc portable) ###

chol.string <- read.csv("C:/Users/serin/OneDrive - USherbrooke/1- UdeS/1-Ma�trise/RNA_chol_gene_asd/Set de g�nes/chol_set_gene.csv"
                        , header = TRUE)


### Convergence du set de g�ne choest�rol dans le dataset ###

idx <- tempdf$SYMBOL %in% chol.string$Gene.symbol
table(idx)

data.chol <- data_log2[idx,]                    
dim(data.chol)
row.names(data.chol) <- tempdf$SYMBOL[which(idx)]
#data.fmr1.log2<-log2(data.fmr1)


### cluster heatmap chol ### pheatmap() ###

pheatmap(
  data.chol
  ,cluster_cols = TRUE
  #,show_rownames=FALSE
)


### PCA chol ### prcomp() ###

pca_chol <- prcomp(t(data.chol), scale = T)
plot(pca_chol$x[,1], pca_chol$x[,2])

pca_chol.var <- pca_chol$sdev^2
pca_chol.var.per <- round(pca_chol.var/sum(pca_chol.var)*100, 1)

barplot(pca_chol.var.per, main="Percent variation for each principal component", xlab="Principal Component", ylab="Percent Variation",
        ylim= range(pretty(c(0, pca_chol.var.per))))


### PCA chol ### ggplot2() ###
library(ggplot2)

pca_chol.data <- data.frame(Sample=rownames(pca_chol$x),
                            X=pca_chol$x[,1],
                            Y=pca_chol$x[,2])
pca_chol.data

ggplot(data=pca_chol.data, aes(x = X, y = Y, label = Sample, color = factor(Sample))) +
  geom_text(hjust = 0, nudge_x = 0.2) +
  geom_point() +
  xlab(paste("PC1 - ", pca_chol.var.per[1], "%", sep ="")) +
  ylab(paste("PC2 - ", pca_chol.var.per[2], "%", sep ="")) +
  theme_bw() +
  ggtitle("Cholesterol PCA Graph - GSE102741")

#Top genes variation

loading_scores <- pca_chol$rotation[,1]
gene_scores <- abs(loading_scores) ## get the magnitudes
gene_score_ranked <- sort(gene_scores, decreasing=TRUE)
top_10_genes <- names(gene_score_ranked[1:10])

top_10_genes ## show the names of the top 10 genes
pca_chol$rotation[top_10_genes,1] ## show the scores (and +/- sign)

library(data.table)
top_10_genes_chol_pca <- pca_chol$rotation[top_10_genes,1]
top_10_genes_chol_pca <- as.data.frame(top_10_genes_chol_pca)

top_10_genes_chol_pca <- setDT(top_10_genes_chol_pca, keep.rownames = T)[]
colnames(top_10_genes_chol_pca) <- c("Genes","Variation")
top_10_genes_chol_pca


ggplot(data=top_10_genes_chol_pca, aes(x = reorder(Genes, -Variation), y = Variation)) + 
  geom_bar(stat="identity",color = "blue", fill = "gray") + 
  geom_text(aes(label= sprintf("%0.3f",top_10_genes_chol_pca$Variation)), vjust=0.5, hjust = -0.2, size=3.5) +
  coord_flip() +
  ggtitle("Top 10 genes associated with cholesterol influencing the PCA graph - GSE102741") +
  labs(x = "Genes", y = "Score")





