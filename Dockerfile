FROM bioconductor/bioconductor_docker:devel

RUN Rscript -e "install.packages(c('knitr', 'rmarkdown', 'pkgdown'), repos = 'https://cloud.r-project.org')"

RUN Rscript -e "BiocManager::install()"
RUN Rscript -e "BiocManager::install('Biobase')"
RUN Rscript -e "BiocManager::install('DiffBind')"


WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); devtools::install('.', dependencies=FALSE, build_vignettes=TRUE, repos = BiocManager::repositories())"

