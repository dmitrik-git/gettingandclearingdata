# Question 1
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

# which(agricultureLogical)

# What are the first 3 values that result?

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists("data")) {
  dir.create("data")
} 
download.file(fileURL, destfile = "./data/2006survey.csv")
dateDownloaded <- date()
data <- read.csv("./data/2006survey.csv")

agricultureLogical <- data$ACR == 3 & data$AGS == 6
which(agricultureLogical)

# Question 2
# Using the jpeg package read in the following picture of your instructor into R

install.packages("jpeg")
library(jpeg)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
if (!file.exists("data")) {
  dir.create("data")
} 

download.file(fileURL, destfile = "./data/jeff.jpg", mode = "wb")
data <- readJPEG("./data/jeff.jpg", native = TRUE)
quantile (data, probs = c(0.3, 0.8))

# Question 3

# Match the data based on the country shortcode. 
# How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?

if (!file.exists("data")) {
  dir.create("data")
} 
fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileURL1, destfile = "./data/GDP.csv", mode = "wb")
download.file(fileURL2, destfile = "./data/Country.csv")
dateDownloaded <- date()

gdps <- read.csv("./data/GDP.csv", blank.lines.skip = TRUE, skip = 4, na.strings = "", skipNul = TRUE)
# str(gdps) gives someuseful info about columns
gdps_clean <- data.frame ("CountryCode" = gdps$X, "Rank" = as.integer(gdps$X.1), "Country" = gdps$X.3, "GDP" = as.numeric(gdps$X.4))
gdps_clean <- gdps_clean[rowSums(is.na(gdps_clean)) != ncol(gdps_clean), ]
# remove rows with all NAs
gdps_clean <- gdps_clean[!is.na(gdps_clean$Rank),]

countries <- read.csv("./data/Country.csv")

install.packages("plyr")
library(plyr)
arrangedData <- arrange(join(gdps_clean, countries), desc(Rank))

# Question 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

install.packages("reshape2")
library(reshape2)
meltedData <- melt (arrangedData, id = "Income.Group", measure.vars = "Rank")
dcast(meltedData, Income.Group ~ variable, mean)

# Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?

qntl <- quantile (arrangedData$Rank, probs = c(.2, .4, .6, .8, 1))

#adding a new variable whith value equal to the quantile slice
arrangedData$groupSlice <- cut(arrangedData$Rank, breaks = qntl)
table(arrangedData$groupSlice, arrangedData$Income.Group)




