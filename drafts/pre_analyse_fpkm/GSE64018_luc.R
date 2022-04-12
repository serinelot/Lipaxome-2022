setwd("~/Documents/ASD_GEO_2019/GSE64018/")

library(pheatmap)

library(org.Hs.eg.db)
library(EnsDb.Hsapiens.v86)
keytypes(org.Hs.eg.db)

data <- read.csv('GSE64018_adjfpkm_12asd_12ctl.csv',
                 header = TRUE, 
                 row.names = 1)

index <- rowSums(data) > 100
index <- rowSums(data > 0) == ncol(data) 
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

names(data_log2)[1:12] <- 'ASD'
names(data_log2)[13:24] <- 'Ctrl'

fmr1.string <- read.csv("../string_protein_annotations_FMR1.csv"
                        , header = TRUE)

idx <- tempdf$SYMBOL %in% fmr1.string$Gene.symbol
table(idx)

data.fmr1 <- data_log2[idx,]                    
dim(data.fmr1)

row.names(data.fmr1) <- tempdf$SYMBOL[which(idx)]

pheatmap(
  data.fmr1
  #,show_rownames=FALSE
)

chol.string <- read.csv("../CholesterolKEGG.csv"
                        , header = TRUE
)

idx <- tempdf$SYMBOL %in% chol.string$Gene.symbol
table(idx)

data.chol <- data_log2[idx,]                    
dim(data.chol)
row.names(data.chol) <- tempdf$SYMBOL[which(idx)]
#data.fmr1.log2<-log2(data.fmr1)

pheatmap(
  data.chol
  ,cluster_cols = TRUE
  #,show_rownames=FALSE
)


library(GEOquery)

g <- getGEO('GSE64018')
#getGEOSuppFiles('GSE102741')
names(g)
e <- g[[1]]
e

library(limma)

design <- model.matrix(~ e@phenoData@data$characteristics_ch1.2)
table(design)
# fit <- lmFit(data, design=design)
# fit <- eBayes(fit)
# tt <- topTable(fit, coef=2, genelist=gene.symbol[2])
# tt

r1 <- roast(data_log2, idx, design)
# ?roast
r1
