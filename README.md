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
(up to and including differential binding analysis), 
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
A mini-lecture will be given at the beginning that will cover basic ideas behind ChIP-seq, comparision of commonly used tools for ChIP-seq data analysis. Then, a hands-on demo will be performed to demonstrate the downstream analysis with ChIPpeakAnno and trackViewer packages. Last will be a Q/A section.

## How to run Docker
- Install Docker (https://www.docker.com/)
- Pull the Docker image from Docker hub:
  `docker pull crukcibioinformatics/QuantitativeChIP_workshop`
- Run the image:
  `docker run -e PASSWORD=yourpassword -p 8787:8787 crukcibioinformatics/QuantitativeChIP_workshop`
- Log in to RStudio at [http://localhost:8787](http://localhost:8787) using username `rstudio` and password `yourpassword`. For Windows users, you also need to provide your IP address, you can find it using `docker-machine ip default`.
- Inside the RStudio, run:
  `browseVignettes(package = "crukcibioinformatics/QuantitativeChIP_workshop")`
- You can click one of the links: "HTML", "source", "R code"

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
| Normalization I                 |  5m  |
| GLM model design and contrasts  | 10m  |
| Normalization II                | 10m  |
| Reporting                       |  5m  |
| Plotting                        | 10m  |
| Exporting results for downstream analysis |  5m  |
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
