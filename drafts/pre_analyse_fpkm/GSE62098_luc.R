setwd("~/Documents/ASD_GEO_2019/GSE62098")

library(pheatmap)

data <- read.csv('GSE62098_processedFPKMS.csv', header = TRUE, row.names = 1)

index <- rowSums(data)>0
#index <- rowSums(data == 0) == 0 #== ncol(data) 
index <- rowSums(data > 0) == ncol(data)
table(index)

data <- data[index,]

data_log2 <-log2(data)
data_log2[data_log2 == -Inf] <- 0

# pheatmap(
#   data_log2
#   ,show_rownames=FALSE
# )
# head(data)

fmr1.string <- read.csv("../string_protein_annotations_FMR1.csv"
                        , header = TRUE)
idx <- row.names(data) %in% fmr1.string$Gene.symbol
table(idx)

data.fmr1 <- data_log2[idx,]                    
dim(data.fmr1)

pheatmap(
  data.fmr1
  #,show_rownames=FALSE
)

chol.string <- read.csv("../CholesterolKEGG.csv"
                        , header = TRUE
                        )

idx <- row.names(data) %in% chol.string$Gene.symbol
table(idx)

data.chol <- data_log2[idx,]                    
dim(data.chol)

#data.fmr1.log10<-log10(data.fmr1)

pheatmap(
  data.chol
  #,show_rownames=FALSE
)

names(data.chol)

ridx <- names(data.chol) %in%  c("ASD.5302", "Ctl.5242")

pheatmap(
  data.chol[,!ridx]
  #,show_rownames=FALSE
)

library(GEOquery)

g <- getGEO('GSE62098')
#getGEOSuppFiles('GSE102741')
names(g)
e <- g[[1]]
e

library(limma)

design <- model.matrix(~ e@phenoData@data$characteristics_ch1.1)
# fit <- lmFit(data, design=design)
# fit <- eBayes(fit)
# tt <- topTable(fit, coef=2, genelist=gene.symbol[2])
# tt

r1 <- roast(data_log2, idx, design)
# ?roast
r1

