norm.comp <- NULL

for(norm in c("lib","RLE","TMM")) {
  for(libsize in c("full","RiP","background")) {
    tam <- NULL
    background <- offsets <- FALSE
    if(libsize == "full" && norm != "lib") {
      background <- NULL
    }
    if(libsize == DBA_LIBSIZE_BACKGROUND) {
      background <- TRUE
      if(norm == DBA_NORM_LIB) {
        background <- NULL
      }
    } 
    if(norm == "loess" && !is.null(background)) {
      offsets <- TRUE
      if(libsize != "background") {
        background <- FALSE
      } else {
        background <- NULL
      }
    }
    if(!is.null(background)) {
      tam <- dba.normalize(tam.model, method=DBA_ALL_METHODS,
                           normalize=norm, library=libsize, 
                           background=background, offsets=offsets)
    }
    if(!is.null(tam)) {
      tam <- dba.analyze(tam)
      db <- dba.report(tam, bDB=TRUE)
      if(libsize == "background") {
        libstr <- "BG"
      } else {
        libstr <- libsize
      }
      id <- paste(norm,libstr,sep="_")
      if(libsize == "full") {
        libstr <- "BG"
      }
      if(is.null(norm.comp)) {
        norm.comp <- db
        norm.comp$config$factor    <- "Normalization Method"
        norm.comp$config$condition <- "Reference Reads"
        norm.comp$config$treatment <- "Analysis Method"
        norm.comp$class[DBA_ID,]  <- colnames(norm.comp$class)[1] <- id
        
        norm.comp$class[DBA_FACTOR,]    <- norm
        norm.comp$class[DBA_CONDITION,] <- libstr
        norm.comp$class[DBA_TREATMENT,] <- "DESeq2"
        norm.comp$class[DBA_TISSUE,]    <- NA
      } else {
        db$class[DBA_ID,]        <- id
        db$class[DBA_FACTOR,]    <- norm
        db$class[DBA_CONDITION,] <- libstr
        db$class[DBA_TREATMENT,] <- "DESeq2"
        db$class[DBA_TISSUE,]    <- NA
        norm.comp <- dba.peakset(norm.comp,db)
      }
    }
  }
}
norm.comp <- dba(norm.comp,minOverlap=1)
norm.comp
dba.save(norm.comp,"norm_comp.rda")