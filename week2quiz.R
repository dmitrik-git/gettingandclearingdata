# Helpful resource used during this assignment 
# https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-week-2/
# https://github.com/r-lib/httr/blob/master/demo/oauth2-github.r

## Question 1

# Required libraries
library(httr)
download.packages("httpuv",getwd())
install.packages("httpuv")
library(httpuv)
library(jsonlite)

myapp <- oauth_app("github",key="Iv1.c366729e7a7fa61e",secret = "c1a5f2de9b70427e806f041c699844df810d68af") 
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp) 
gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
raw_result <- content(req)
str(raw_result)

jsoned <- toJSON(raw_result)
df <- fromJSON(jsoned)
df[df$name == "datasharing","created_at"]

## Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html
# (Hint: the nchar() function in R may be helpful)

con = url ("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close (con)
for (i in c(10, 20, 30, 100)) {
  a <- nchar(htmlCode[i])  
  print (a)
}

## Question 5

# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed width file format)

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
fwf = read.fwf (file, widths = c(15, 4, 4, 9, 9, 4, 9, 4, 4 ), skip = 4)
sum(fwf[,4])
