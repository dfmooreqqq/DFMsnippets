installpackages <- function(packages){
    packages <- lapply(packages, FUN = function(x) {
        if (!require(x, character.only = TRUE)) {
            install.packages(x)
            library(x, character.only = TRUE)
        }
    })
}


loadinfilesinzip <- function(folder=getwd()){
    currentwd<-getwd()
    setwd(folder)
    listofzipfiles <- list.files(pattern=".zip")
    patternfilestoread <- ".csv"
    pb<-txtProgressBar(1, length(listofzipfiles), style=3)
    pbi<-0
    for (i in listofzipfiles) {
        pbi<-pbi+1
        setTxtProgressBar(pb, pbi)
        zipdir <- tempfile()
        dir.create(zipdir)
        unzip(i, exdir = zipdir)
        b<-strsplit(i, "\\.")
        b<-b[[1]][1]
        k<-0
        for (j in list.files(path = zipdir, pattern=patternfilestoread)){
            k<-k+1
            filestr = paste(b,j, sep="_")
            assign(filestr,read.csv(paste(zipdir,j, sep="\\")))
        }
    }
}