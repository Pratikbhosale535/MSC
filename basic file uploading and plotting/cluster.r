
###new
a <- read.csv(file="F:\\PRATIK\\cardata.csv")
dat <- a %>% filter(a$Company_name == 'Maruti Suzuki' ) %>% select(Model_Name,Location,Mileage_Kmpl,Engine_Cc,Power_Bhp)
print(dat)
d <- data.matrix(dat[-1])
d1<- na.omit(d)
d2 <- scale(d1)


mydata <- d2
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main="Assessing the Optimal Number of Clusters with the Elbow Method",
     pch=20, cex=2)


# Perform K-Means with the optimal number of clusters identified from the Elbow method
set.seed(5)
km2 = kmeans(d2, 4, nstart=100)

# Examine the result of the clustering algorithm
km2
# Plot results
plot(dat, col =(km2$cluster +1) ,
     main="K-Means result with 6 clusters", pch=20, cex=2)















a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
structure(a)


##scatter plot
plot(Engine_Cc~Mileage_Kmpl,a)
with(a,text(Mileage_Kmpl~Power_Bhp),labels=Sub_Model_Name,pos=4,cex=.4)

##normalization
z <- a[,-c(2,3,4,5,8,9,10,1)]
z
m <- apply(z,2,mean)
s <- apply(z,2,sd)
z <- scale(z,m,s)

##ecluidain dist
distance <- dist(z)
distance


##cluster dendogram
hc.c <- hclust(distance)
plot(hc.c)

#average
hc.a <- hclust(distance,method = "average")
plot(hc.a,hang=-1 )

##cluster membership
member.c <- cutree(hc.c,4)
member.a <- cutree(hc.a,4)
table(member.a,member.c)

##cluster meeans 
aggregate(z,list(member.c),mean)


###k means cluster
kc <- kmeans(z,5)
kc
kc$cluster
kc$totss
plot(Engine_Cc~Mileage_Kmpl,a,col=kc$cluster)
summary(kc$cluster)








#Loading iris dataset
data(iris)

#Viewing the head of iris
head(iris)

#Removing "Species column"
iris_2<-iris[-5]
head(iris_2)

#Standardize data
iris_3<-as.data.frame(scale(iris_2))
head(iris_3)

#Checking Mean and SD of data before and after standardization
sapply(iris_2,mean)
sapply(iris_2,sd)
sapply(iris_3,mean)
sapply(iris_3,sd)

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
wssplot(iris_3,nc=30,seed=1234)

# fitting the clusters
iris_kmeans<-kmeans(iris_3,7)
iris_kmeans$centers
iris_kmeans$size
iris$clstr<-iris_kmeans$cluster

# cross-validation with original species available in data

iris$clstr<-iris_kmeans$cluster
table(iris$Species,iris$clstr 