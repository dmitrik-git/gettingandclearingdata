fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists("data")) {
  dir.create("data")
} 
download.file(fileURL, destfile = "./data/2006survey.csv")
dateDownloaded <- date()
data <- read.csv("./data/2006survey.csv")

agricultureLogical <- data$ACR == 3 & data$AGS == 6
which(agricultureLogical)

