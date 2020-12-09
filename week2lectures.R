# On data cleaning 
http://vita.had.co.nz/papers/tidy-data.pdf

# Missing values, NAs

## which() function doesn't include NA's. For example,
X[which(X$var2 > 8),] # will return rows where var2 is larger than 8 and NAs will be excluded.

sum(is.na(df$var1)) # as TRUE counts as 1, if sum is > 0 then there are missing values
any(is.na(df$var1)) # if there is at least 1 NA then it will return TRUE
all(is.na(df$var1)) # will return TRUE if all values correspond to logical criteria
colSums(is.na(df)) # will count the sumper each column in the dataset
all(colSums(is.na(df)) == 0) # if TRUE then there are no missing values in the whole dataset

table(df$var1 %in% c("a", "b")) # are there any values where var1 is either "a" or "b"
 
# Sorting and ordering

sort(X$var1)
X[order(X$var1, X$var3), ]

library(plyr)
arrange (X, desc(var1))

# Adding rows and columns

X$var4 <- rnorm(5) #or
Y <- cbind(X, rnorm(5)) # the new column as at the right. If you want to have it on the left then use
Y <- cbind(rnorm(5), X)
# Rows can be added using rbind().

# a category variable
df$cat1 <- cut(df$var1, breaks = quantile(df$var1)) #it will add a new variable which corresponds to the quantile of var1

# Melting data

dfMelt <- melt(df, id=c("var1", "var2"), measure.vars = c("var3", "var4"))
# var1 and var2 are id variables meaning that the new data set will contain unique combinations of thise.
# While var3 and var4 will be put into one column.

dfCast <- dcast(dfMelt, var1 ~ variable, mean)
# dcast works only with melted data frames. it will sum up data for all variables based on var1

# Splitting

dfSplit <- split(df$var1, df$var2) # the new object will list all different values of var1 grouped by var2
lapply (dfSplit, sum) # this will sum up all values grouped by var2

# Sequences

seq(1,10, by=2) # sequence vector from 1 to 10 incremented by 2
seq(1,10, length = 3) # vector of values between 1 and 10 with 3 elements


# Summaryzing

summary (df)
str(df) # includes dimensions and classes of variables
quantile(df$var1, probs = c(.5, .75, .9))
table(df$var1, useNA = "ifany") # will count the number of observations per each value of var and will add an extra row to count NAs
table(df$var1, df$var2) # a cross table on two variables
xtabs (var1 ~ var2 + var3, data = df) # var1 is the cross value between var2 and var3  
object.size(df)
print (object.size(df), units = "Mb")

# Merging data

library(plyr)
merge (df1, df2, by.x="a", by.y="b", all=TRUE) # "a" is the key column in df1 and "b" is the key column in df2
join_all 






