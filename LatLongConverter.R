#### Function to convert degrees and decimal minutes to decimal degrees
decdeg<-function(c){
  degmin<-do.call(rbind, strsplit(c,':')) #splits both the lat and long data into two at the ":" symbol
  deg<-as.numeric(degmin[,1]) #extract the first column - these are the degrees
  min<-as.numeric(degmin[,2]) #extract the second column - these are the decimal minutes
  dd<-(abs(deg))+(min/60) 
  dd<-ifelse(deg<0,-dd,dd) #this will preserve the negative value
  return(dd)
}
#### End function

#### Import coordinate data ####
##input lat/long data should be in two columns and of the form "36:57.039" and "-122:03.953"
##Note - "stringsAsFactors = FALSE" tells R to keep character variables as they are, rather than converting to factors
coord<-read.table("gpspoints.tab", sep="\t", header=F, stringsAsFactors = FALSE) 
colnames(coord)<-c("id","lat","long") #attach column names

####Combine lat and long results into a data frame
dd.long<-decdeg(coord$long)
dd.lat<-decdeg(coord$lat)
output<-data.frame(dd.lat,dd.long)
print(output)

####Save output to tab delimited file output.txt
write.table(output, file="gpspoints_dd.txt", row.name=F, col.name=T, sep="\t")

