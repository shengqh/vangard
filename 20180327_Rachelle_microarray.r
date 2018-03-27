library(limma)

setwd("H:/shengquanhu/projects/VANGARD/20180327_rachelle_microarray")

pdata<-read.table("Expression data from Connolly 3.26.18.txt", header=T)

cdata<-pdata[,c(-1,-2)]
adata<-avereps(cdata, ID=pdata$ProbeName)

Patient=as.factor(gsub(".p.*", "", colnames(adata)))
Post=as.factor(grepl("post", colnames(adata)))
design <- model.matrix(~Patient+Post)
fit <- lmFit(adata, design)
fit <- eBayes(fit)
tp<-topTable(fit, coef="PostTRUE", number=nrow(fit))

norep<-pdata[,c(1,2)]
norep<-norep[!duplicated(norep$ProbeName),]
rownames(norep)<-norep$ProbeName

tp$Gene<-norep[rownames(tp),"GeneName"]

write.csv(tp, file="20180327_rachelle_microarray.csv")
