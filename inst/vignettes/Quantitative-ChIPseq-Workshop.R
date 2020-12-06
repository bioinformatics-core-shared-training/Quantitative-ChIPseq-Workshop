## ---- setup, include=FALSE----------------------------------------------------
library(knitr)
knitr::opts_chunk$set(out.width="100%", cache=TRUE)
knitr::opts_knit$set(root.dir="../inst/extdata")

## ----loadpackages-------------------------------------------------------------
library(DiffBind)
library(GreyListChIP)
library(csaw)

## ----showdir------------------------------------------------------------------
getwd()

## ----chrdir, eval=FALSE,echo=TRUE---------------------------------------------
#  setwd("inst/extdata")

## ----samplesheet--------------------------------------------------------------
samples <- read.csv("tamoxifen.csv")
samples

## ----loadsamples--------------------------------------------------------------
tam.peaks <- dba(sampleSheet="tamoxifen.csv")

## ----showtam------------------------------------------------------------------
tam.peaks

## ----blacklist----------------------------------------------------------------
dba.blacklist(tam.peaks, blacklist=TRUE, greylist=FALSE)

## ----greylist, eval=FALSE-----------------------------------------------------
#  tam.peaks <- dba.blacklist(tam.peaks)

## ----loadgrey-----------------------------------------------------------------
data(tamoxifen_greylist)
names(tamoxifen.greylist)

## ----greymaster---------------------------------------------------------------
tamoxifen.greylist$master
names(tamoxifen.greylist$controls)

## ----applygrey----------------------------------------------------------------
tam.peaks <- dba.blacklist(tam.peaks, blacklist=DBA_BLACKLIST_HG19,
                           greylist=tamoxifen.greylist)

## ----rateplot-----------------------------------------------------------------
olap.rate <- dba.overlap(tam.peaks, mode=DBA_OLAP_RATE)
olap.rate
plot(olap.rate, xlab="Overlapping samples", ylab="Overlapping peaks", type="b")

## ----consensus----------------------------------------------------------------
consensus.peaks <- dba.peakset(tam.peaks, bRetrieve=TRUE)
consensus.peaks[,0]

## ----count, eval=FALSE--------------------------------------------------------
#  tam.counts <- dba.count(tam.peaks)

## ----loadcounts---------------------------------------------------------------
data(tamoxifen_counts)
tam.counts <- tamoxifen

## ----countobject--------------------------------------------------------------
tam.counts

## ----counthm------------------------------------------------------------------
plot(tam.counts)

## ----countPCA-----------------------------------------------------------------
dba.plotPCA(tam.counts,DBA_REPLICATE, label=DBA_TISSUE)

## ----maraw--------------------------------------------------------------------
dba.plotMA(tam.counts, bNormalized=FALSE, sub="Non-Normalized",
           contrast=list(Resistant=tam.counts$masks$Resistant,
                         Responsive=tam.counts$masks$Responsive))

## ----normdef------------------------------------------------------------------
tam.counts <- dba.normalize(tam.counts)
dba.plotMA(tam.counts, sub="Normalized (Default)",
           contrast=list(Resistant=tam.counts$masks$Resistant,
                         Responsive=tam.counts$masks$Responsive))

## ----modeldef-----------------------------------------------------------------
tam.model <- dba.contrast(tam.counts)
tam.model

## ----analyze------------------------------------------------------------------
tam.model <- dba.analyze(tam.model)
dba.show(tam.model,bContrasts=TRUE)

## ----report-------------------------------------------------------------------
tam.db <- dba.report(tam.model)
tam.db

## ----gainloss-----------------------------------------------------------------
sum(tam.db$Fold>0)
sum(tam.db$Fold<0)

## ----macontrast---------------------------------------------------------------
dba.plotMA(tam.model)

## ----volcano------------------------------------------------------------------
dba.plotVolcano(tam.model)

## ----corhmcontrast------------------------------------------------------------
plot(tam.model, contrast=1)

## ----pcacontrast--------------------------------------------------------------
dba.plotPCA(tam.model, contrast=1, label=DBA_TISSUE)

## ----hmcontrast---------------------------------------------------------------
hmap <- colorRampPalette(c("red", "black", "green"))(n = 13)
readscores <- dba.plotHeatmap(tam.model, contrast=1, correlations=FALSE,
                              scale="row", colScheme = hmap)

## ----modelmulti---------------------------------------------------------------
tam.model <- dba.contrast(tam.model, design="~Tissue + Condition")
dba.show(tam.model,bDesign=TRUE)
tam.model <- dba.analyze(tam.model)
tam.model

## ----mamulti------------------------------------------------------------------
dba.plotMA(tam.model, contrast=1)

