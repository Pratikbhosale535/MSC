#Loading a dataset
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")

#Viewing the head of a
head(a)

#Removing "Species column"
a_2<-a[,-c(2,3,4,5,8,9,10,1)]
head(a_2)

#Standardize data
a_3<-as.data.frame(scale(a_2))
head(a_3)

#Checking Mean and SD of data before and after standardization
sapply(a_2,mean)
sapply(a_2,sd)
sapply(a_3,mean)
sapply(a_3,sd)

library(NbClust)

# creating function wssplot
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

# calling function wssplot()
wssplot(a_3,nc=30,seed=1234)

# fitting the clusters
a_kmeans<-kmeans(a_3,7)
a_kmeans$centers
a_kmeans$size
a$clstr<-a_kmeans$cluster

# cross-validation with original species available in data

a$clstr<-a_kmeans$cluster
b <-table(a$Company_name,a$clstr)
summary(b)      
      