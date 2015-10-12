## =======================================================
##
## Sept 17, 2015 -- Tobias Doppler
##
## =======================================================

## =================================
## Run: Rscript FloDar2Standard.r rawData/split_floDarSite 2, Inflow upstream_20131203.txt
##
## writes files data_%SourceInstanceName%.csv
## =================================

# load required package
if(!require("reshape2")) install.packages("reshape2", repos="http://cran.rstudio.com/")

## read file name as command line argument
args <- commandArgs(trailingOnly = TRUE)

if(is.na(args[1])) stop("Provide file name of raw file!")
file.raw <- args[1]

## for naming of output file
source.instance <- "FloDar_Adliswil_2"

## define coordinate
xcoor <- 682558
ycoor <- 239404
zcoor <- ""

## --- read files
data.raw<-read.table(file.raw,sep="\t",skip=1,header=F)
names(data.raw) <- c("Date Time", "Water Level", "Average Flow Velocity", "Flow", "Temperature", "Surface Flow Velocity", "Distance", "Distance Reading Count", 
		     "Surcharge Level", "Peak to Mean Ratio", "Number of Samples", "Battery Voltage")

## format time
time <- strptime(data.raw$"Date Time", "%d.%m.%Y %H:%M")
data.raw$"Date Time" <- format(time, "%Y-%m-%d %H:%M:%S")

## reformat data
data.form <- melt(data.raw, id.vars = c("Date Time"))
colnames(data.form) <- c("Timestamp", "Parameter", "Value")
data.form$Group_ID <- ""
data.form$X <- xcoor
data.form$Y <- ycoor
data.form$Z <- zcoor

## remove NA values
data.form <- na.omit(data.form)

## write data
file.name <- paste0("./data/data_", source.instance, ".csv")

suppressWarnings(
write.table(data.form, file=file.name, append=TRUE,
            row.names=FALSE, col.names=!file.exists(file.name),
            quote=FALSE, sep=";")
)
print(paste0("File ", file.name, " written or updated."))


