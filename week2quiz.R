# Helpful resource used during this assignment 
# https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-week-2/

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



# datasharing repo