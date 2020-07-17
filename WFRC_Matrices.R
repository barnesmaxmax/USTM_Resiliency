library(devtools)
library(omxr)
library(rhdf5)
library(Rhdf5lib)
library(tidyverse)

h5closeAll()  ##Closes any open database if an error occurs during normal code i.e. the datapase doesn't close if an error occurs
testamtrix <- read_csv(file = "/Users/maxbarnes/Documents/GitHub/USTM_Resiliency/testmatrix.csv")

zones <- 1:2881
rhdf5::H5close()

omxfile <- ("/Users/maxbarnes/Documents/GitHub/USTM_Resiliency/testmatrix.omx")
#omxfile <- tempfile(fileext = ".omx")
create_omx(omxfile, numrows = length(zones), numcols = length(zones))

testamtrix$w4time <- NULL

testmatrix <- data.matrix(testamtrix)


##use this to add more than one matrix to the same file
#trips <- matrix(rnorm(n = length(zones)^2, 200, 50),  
    #          nrow = length(zones), ncol = length(zones))
#cost <- matrix(rlnorm(n = length(zones)^2, 1, 1),
             # nrow = length(zones), ncol = length(zones))

write_omx(file = omxfile, matrix = testmatrix, "Pk_Transit", description = "Peak Transit Time")
a <- read_omx(omxfile, name = "Pk_Transit")

skims <- ("/Users/maxbarnes/Documents/GitHub/USTM_Resiliency/Skims/skims.omx")


list_omx(skims)

h5ls(skims, recursive = TRUE, all = FALSE, datasetinfo = TRUE, 
      index_type = h5default("H5_INDEX"), order = h5default("h5_ITER"), native = FALSE)
