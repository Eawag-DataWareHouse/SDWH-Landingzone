# Script to split files from Datalogger FL902, with attached FloDar and AV9000
# Into two files (one for FloDar, one for AV9000) and write these files in the 
# corresponding folder in the landing zone.

args <- commandArgs(trailingOnly = TRUE)

if(is.na(args[1])) stop("Provide file name of raw file!")
file.raw <- args[1]

split<-gregexpr(pattern ='/',file.raw)[[1]]
splitter<-split[length(split)]
split2<-gregexpr(pattern ='.',file.raw,fixed=T)[[1]]
splitter2<-split2[length(split2)]
filename<-substr(file.raw,splitter+1,splitter2)

head<-as.character(read.table(file.raw,sep="\t",nrows=1,as.is=T))
fulldat<-read.table(file.raw,sep="\t",skip=1)
names(fulldat)<-head

dat.av9000<-fulldat[,c(1,2,3,4,5,6,17)]
dat.floDar<-fulldat[,c(1,7:17)]

write.table(dat.av9000, file=paste0("../../Data/AV9000/AV9000_Adliswil_2/rawData/split_av9000_",filename,"txt"),
            col.names=T,row.names=F,quote=F,sep="\t")

write.table(dat.floDar, file=paste0("../../Data/FloDar/FloDar_Adliswil_2/rawData/split_floDar_",filename,"txt"),
            col.names=T,row.names=F,quote=F,sep="\t")

