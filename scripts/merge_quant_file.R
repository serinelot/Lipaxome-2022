library(data.table) #n'arrive pas a telecharger le package

data <- snakemake@input[["counts"]]

count_data <- NULL

for (i in seq(1, length(data))) {
  
  count_data[i] <- read.table(data())
  
  count_data[i] <- count_data
}


data    <- read.table('/home/serinelot/projects/lipaxome-pipeline/results/featureCounts/SRR1603662_gene_counts.tsv', skip = 1, header = TRUE, sep = c('\t',';'))
data <- data[, -c(2,3,4,5,6)]

column_name <- colnames(data)
bam_column <- column_name[2]

srr_id_list <- strsplit(bam_column, split = ".", fixed = TRUE)
srr_id_str <- unlist(srr_id_list)
srr_id <- srr_id_str[3]

names(data)[names(data) == bam_column] <- srr_id


write.table(
  snakemkake@output[["merged_counts"]] #crochet pas de parenthese
)
