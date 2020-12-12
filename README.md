---
title: "Quantitative-ChIPseq-Workshop"
author: "Rory Stark"
date: "November 25, 2020"
output: html_document
---

# Quantitiative analysis of ChiP-seq, ATAC-seq, and related DNA enrichment assays.

# Instructor

Rory Stark, Principal Scientist Computational Biology, University of Cambridge,
Cancer Research UK Cambridge Institute

rory.stark@cruk.cam.ac.uk


# Workshop Description

This workshop will demonstrate the steps involved in performing a 
quantitative analysis of ChIP-seq data in _Bioconductor_
(specifically differential binding analysis), 
with some discussion of related assays such as ATAC-seq.
Particular attention will be paid to processing of aligned reads, 
including blacklisting, greylisting, filtering for quality and duplication,
and the particular challenges presented when normalizing these data.
While the workshop follows the _DiffBind_ package vignette, the use of 
a number of other _Bioconductor_ packages is discussed, including
_csaw_, _ChIPQC_, _edgeR_, _DESeq2_, and 
_GreyListChIP_.

## Pre-requisites

Attendees should be familiar with the following:

* Basic knowledge of R syntax
* Familiarity with core _Bioconductor_ classes, such as 
_GRanges_.
* Familiarity with ChIP-seq or a related assay, 
including aligning sequencing reads.
* Familiarity with generalized linear models (GLMs),  especially
as realized in the _edgeR_ and/or _DESeq2_ packages.

Helpful background reading:

* Read through the _DiffBind_ package vignette
* Read through the _csaw_ package vignette

There is a book chapter which offers a detailed outline of the design and 
analysis of ChIP-seq experiments:

* Stark, Rory, and James Hadfield. 
"Characterization of DNA-protein interactions: design and analysis of
ChIP-seq experiments." 
_Field Guidelines for Genetic Experimental Designs in High-Throughput Sequencing._ 
Springer, Cham, 2016. 223-260.

Email the instructor if you would like a copy.

## Workshop participation
Students will participate by following along an [_R markdown_](https://rmarkdown.rstudio.com/) document, and asking questions throughout the workshop.

The conference organizers have arranged for attendees to have access to a RStudio
session running inside a Docker instance that contains everything you need to follow
the workshop.

**NOTE**: *The workshop Docker instance does not have much compute power.*
*As a result, it is not possible to run all the code in the time allowed.*
*Two operations are affected: building greylists, and counting reads.*
*In these cases, the workshop includes pre-computed data objects that*
*can be loaded to avoid the time-consuming code.*
*This is noted inline.*

## Workshop participation -- local Docker image

If you do **not** have access to the RStudio instance provided by the conference
organizers, or you would like to run the Docker image
locally and you have a Docker client installed on your machine,
you run this workshop locally via:

```
docker pull crukcibioinformatics/quantitative_chip_workshop:latest
docker images
docker run -e PASSWORD=DiffBind -p 8787:8787 <imageid> 
```
Then open a browser and go to the URL **localhost:8787**.
Log into RStudio with **username:rstudio** and **password:DiffBind**.

## Workshop participation -- local R installation

The workshop uses a Docker container with Bioconductor Release version `3.12`.
If you would like to install Bioconductor on your computer,
install R and the required Bioconductor packages,
including this workshop package.

## How to follow the workshop

First load the workshop package:

```
library(QuantitativeChIPseqWorkshop)
```

There are a number of ways to follow the workshop:

### Follow the workshop in the pre-built HTML in RStudio
You can open the fully built workshop (with all code and results) in
the "Help" pane in RStudio as follows:

```
vignette("Quantitative-ChIPseq-Workshop","QuantitativeChIPseqWorkshop")
```

### Follow the workshop in the pre-built HTML in a searate Browser window or tab
If you are using the Docker image,
You can open the fully built workshop (with all code and results) in
a browser tab as follows:

```
rstudioapi::viewer(paste(system.file("doc",package="QuantitativeChIPseqWorkshop"),
                         "Quantitative-ChIPseq-Workshop.html", sep="/"))
```

It may be helpful to move the tab into its own window so you can see the vignette and the RStudio window at the same time.

### Follow the workshop directly in the workshop mark-down file

You can open the workshop "source" .Rmd file in the RStudio
"Source" pane, and follow along, 
executing each code chunk in sequence, to build it as you go.

```
file.edit("vignettes/Quantitative-ChIPseq-Workshop.Rmd")
```

## _R_ / _Bioconductor_ packages used

* _DiffBind_
* _csaw_
* _ChIPQC_
* _DESeq2_
* _edgeR_
* _GreyListChIP_

## Time outline

The workshop duration is 90 min. 
Approximate timing of activities:

| Activity                        | Time |
|-------------------------------- |------|
| Introduction                    |  5m  |
| QC of DNA enrichment assays     |  5m  |
| Peaks vs. Windows               |  5m  |
| _DiffBind_ Sample sheet         |  5m  |
| Blacklists and Greylists        | 10m  |
| Counting aligned reads          | 10m  |
| Examining and normalizing the binding matrix |  10m  |
| Modeling and Testing            |  5m  |
| Examining analysis results      | 10m  |
| Multi-factor Design             |  5m  |
| Normalization discussion        | 15m  |
| Conclusions                     |  5m  |

# Workshop goals and objectives

Participants will learn a complete set of steps for conducting
a differential binding analysis of data from a ChIP-seq or 
related DNA enrichment experiment within _Bioconductor_.

## Learning goals

* Gain an understanding of the processing flow for performing quantitative
analysis of data from ChIP-seq and related DNA enrichment assays
* Be able to filter and count aligned reads to prepare them for analysis
* Appreciate the challenges inherent in normalizing these data
* Complete a differential binding analysis

## Learning objectives

* Load experimental data into _DiffBind_
* Filter aligned reads using blacklists, greylists, and mapping quality
* Derive a consensus peak set and compute a matrix of read counts
* Normalize read counts appropriately
* Establish a design to model the data and one or more 
contrasts to test hypotheses based on the model
* Report, plot, and export results for further analysis
