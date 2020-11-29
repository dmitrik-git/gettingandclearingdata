# Question 1
# code book https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists("data")) {
  dir.create("data")
} 
download.file(fileURL, destfile = "./data/2006survey.csv")
dateDownloaded <- date()
data <- read.csv("./data/2006survey.csv")
sum(data$VAL == 24, na.rm = TRUE)

# Question 3
fileXLS = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# NB! It is important to include mode = 'wb' when downloading xlsx files. Otherwise R won't be able to read the file
download.file(fileXLS, destfile = "./data/ngap.xlsx", mode = 'wb')

# xlsx package must be installed and loaded first. NB! It required Java installation, too.

download.packages("xlsx", getwd())
install.packages("xlsx")
library(xlsx)

rows <- 18:23
cols <- 7:15
data_xls = read.xlsx("./data/ngap.xlsx", sheetIndex = 1, rowIndex = rows, colIndex = cols, header = TRUE)

dat <- data_xls
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4
fileXML = "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

download.packages("XML",getwd())
install.packages("XML")
library(XML)
data_xml <- xmlTreeParse(fileXML, useInternal = TRUE)
topNode <- xmlRoot(data_xml)
zipNode <- getNodeSet(topNode, "//zipcode")
zipValues <- xpathSApply(topNode, "//zipcode",xmlValue)
sum(zipValues == 21231)

# Question 5
# It's not important to run the commands. The correct answers is actually in the lesson. 
# Table package is faster when it comes to subsetting and using by= operator. 
# So one must look for the answer closest to this.

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
if (!file.exists("data")) {
  dir.create("data")
} 
download.file(fileURL, destfile = "./data/communities.csv")
dateDownloaded <- date()

install.packages("data.table")
library("data.table")
DT <- fread ("./data/communities.csv")


system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15))

system.time (DT[, mean(pwgtp15), by=SEX])

system.time (mean(DT$pwgtp15, by=DT$SEX))

system.time (tapply(DT$pwgtp15, DT$SEX, mean))
system.time (sapply(split(DT$pwgtp15, DT$SEX), mean))
system.time (rowMeans(DT)[DT$SEX==1])
system.time (rowMeans(DT)[DT$SEX==2])



