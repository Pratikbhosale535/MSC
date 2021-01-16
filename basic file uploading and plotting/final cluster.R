library(factoextra)
library(NbClust)
library(plotly)

#Loading a dataset
a <- read.csv(file="F:\\PRATIK\\basic file uploading and plotting\\cardata.csv")

#Viewing the head of a
head(a)

#Removing "text column"
#a_2<-a[,-c(2,3,4,5,8,9,10,1)]
head(a_2)

fviz_nbclust(x, FUNcluster, method = c("silhouette", "wss", "gap_stat"))

# Subset the attitude data
dat = a[,c(11,12)]

# # Plot subset data
# plot(dat, main = "% of favourable responses to
#      Learning and Privilege", pch =20, cex =2)
# 
# # Perform K-Means with 2 clusters
# set.seed(200)
# km1 = kmeans(dat, 2, nstart=5000)
# 
# # Plot results
#  plot(dat, col =(km1$cluster +1)
#             ,
#      main="K-Means result with 2 clusters", pch=20, cex=2
#      )
# 
#  ggplot(dat, aes()) +
#    geom_point(colour = "indianred1", size = 1.5 )

# Check for the optimal number of clusters given the data
mydata <- dat
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main="Assessing the Optimal Number of Clusters with the Elbow Method",
     pch=20, cex=2)


# Perform K-Means with the optimal number of clusters identified from the Elbow method
set.seed(5)
km2 = kmeans(dat, 5, nstart=100)

# Examine the result of the clustering algorithm
km2

# Plot results
plot(dat, col =(km2$cluster +1) ,
     main="K-Means result with 6 clusters", pch=20, cex=2)

# Elbow method
fviz_nbclust(a_2, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")

# Silhouette method
fviz_nbclust(a_2, kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")

# Gap statistic
# nboot = 50 to keep the function speedy. 
# recommended value: nboot= 500 for your analysis.
# Use verbose = FALSE to hide computing progression.
set.seed(123)
fviz_nbclust(a_2, kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method")

















#####my
#Loading a dataset
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")

#Viewing the head of a
head(a)

#Removing "text column"
#a_2<-a[,-c(2,3,4,5,8,9,10,1)]
head(a_2)

# Subset the attitude data
dat = a[,c(11,12)]

mydata <- dat
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main="Assessing the Optimal Number of Clusters with the Elbow Method",
     pch=20, cex=2)


# Perform K-Means with the optimal number of clusters identified from the Elbow method
set.seed(5)
km2 = kmeans(dat, 5, nstart=100)

# Examine the result of the clustering algorithm
km2

# Plot results
plot(dat, col =(km2$cluster +1) ,
     main="K-Means result with 6 clusters", pch=20, cex=2)

