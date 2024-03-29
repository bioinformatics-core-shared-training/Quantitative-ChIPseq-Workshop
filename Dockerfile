FROM bioconductor/bioconductor_docker:RELEASE_3_14

RUN Rscript -e "install.packages(c('rlang', 'knitr', 'rmarkdown', 'bookdown', 'pkgdown'), repos = 'https://cloud.r-project.org')"

RUN Rscript -e "BiocManager::install()"
RUN Rscript -e "BiocManager::install('Biobase')"
RUN Rscript -e "BiocManager::install('DiffBind')"
RUN Rscript -e "BiocManager::install('csaw')"

WORKDIR /home/rstudio
COPY --chown=rstudio:rstudio . /home/rstudio/

RUN wget https://content.cruk.cam.ac.uk/bioinformatics/software/DiffBind/DiffBind_vignette_data.tar.gz 
RUN tar --warning=no-unknown-keyword -xzf DiffBind_vignette_data.tar.gz
RUN rm DiffBind_vignette_data.tar.gz
#RUN rm -rf /home/rstudio/inst/extdata
RUN mv DiffBind_Vignette/reads /home/rstudio/inst/extdata/reads
RUN mv DiffBind_Vignette/peaks /home/rstudio/inst/extdata/peaks
#COPY --chown=rstudio:rstudio  inst/vignettes/Quantitative-ChIPseq-Workshop.Rmd /home/rstudio/vignettes/

RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); devtools::install('/home/rstudio/', dependencies=FALSE, build_vignettes=TRUE, repos = BiocManager::repositories())"

