##  F:\\PRATIK\\basic file uploading and plotting


# tabPanel("LOCATION",selectizeInput('var', 'Select Location ', choices = a$Location )
#          ,plotlyOutput("pl6",height = 520))



cardata <- read.csv(file="F:\\PRATIK\\cardata.csv")

######clustering 18/9/2018
a <- read.csv(file="F:\\PRATIK\\cardata.csv")
head(a)
dat <- a %>% filter(a$Company_name == 'Maruti Suzuki' ) %>% select(Model_Name,Year,Kilometers_Driven)
print(dat)
d <- data.matrix(dat[-1])
d1<- na.omit(d)
d2 <- scale(d1)

#set.seed(123)
final <- kmeans(d1,3)
print(final)

fviz_cluster(final,data = d2)
print(cbind(dat,final$cluster))




###try 18/9
library(dplyr)
library("magrittr")
a <- read.csv(file="F:\\PRATIK\\cardata.csv")
rawdf <- a %>% filter(a$Company_name == 'Maruti Suzuki' ) %>% select(Model_Name,Location,Mileage_Kmpl,Engine_Cc,Power_Bhp)
str(rawdf)
head(rawdf)

desc_stats <- data.frame(
  Min = apply(rawdf, 2, min), # minimum
  Med = apply(rawdf, 2, median), # median
  Mean = apply(rawdf, 2, mean), # mean
  SD = apply(rawdf, 2, sd), # Standard deviation
  Max = apply(rawdf, 2, max) # Maximum
)
desc_stats <- round(desc_stats, 1)
head(desc_stats)

df <- scale(rawdf)
head(df)

set.seed(123)
km.res <- kmeans(scale(rawdf), 4, nstart = 25)
km.res
aggregate(rawdf, by=list(cluster=km.res$cluster), mean)
library("factoextra")
fviz_cluster(km.res, data = df,
             palette = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"),
             ggtheme = theme_minimal(),
             main = "Partitioning Clustering Plot"
)






