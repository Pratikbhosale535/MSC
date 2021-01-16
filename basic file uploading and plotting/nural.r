library(tidyverse)
library(neuralnet)
library(GGally)


## Creating index variable 

# Read the Data
data <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv", header=T)
attach(data)
as<-data[,-c(2,3,4,5,6,8,9,10,1)]
head(as)

##max min normalization
normalize <- function(x)
{
  return((x-min(x))/(max(x)-min(x)))
}
maxmindf <- as.data.frame( sapply(as, normalize))
view(maxmindf)


###train test data 
trainset <- maxmindf[1:3500,]
testset <- maxmindf[3501:5237,]

##nueral network 
nn = neuralnet(Selling_Price_L ~ Kilometers_Driven + Mileage_Kmpl + Engine_Cc + Power_Bhp + Seats+Company_Price_L, trainset, hidden = c(2,1) , linear.output = F )
nn$result.matrix
plot(nn)

##test the selecting output
temp_test <- subset(testset,select=c("Kilometers_Driven" ,"Mileage_Kmpl","Engine_Cc","Power_Bhp","Seats", "Company_Price_L"))
head(temp_test)
nn.results <- compute(nn,temp_test)
view(temp_test)

denormalize <- function(nn)
{
  return(	(nn.results(nn) * (max(nn)-min(nn)) + min(nn)))
}
maxmin <- as.data.frame( sapply(as, denormalize))
view(maxmin)
# 
# denormalized <- function(x)
# {
#   return((maxmindf)*(max(x)-min(x))+min(x))
# }
# tt <- as.data.frame( sapply(as, denormalized))
# view(tt)



##accuracy
results <- data.frame(actual=testset$Selling_Price_L,prediction=nn.results$net.result)
results
roudedresults<-sapply(results,round,digits=0)
roudedresultsdf=data.frame(roudedresults)
attach(roudedresultsdf)
table(actual,prediction)




###neural 2


# Read the Data
library(neuralnet)
library(neural)
class.ind <- function(cl)
{
  n <- length(cl)
  cl <- as.factor(cl)
  x <- matrix(0, n, length(levels(cl)) )
  x[(1:n) + n*(unclass(cl)-1)] <- 1
  dimnames(x) <- list(names(cl), levels(cl))
  x
}
af <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv", header=T)
head(af)
str(af)
car<-cbind(af[,11:16], class.ind(af$Company_name))
head(car)

set.seed(2)
proportion <- 0.80
index <-sample(1:nrow(car),round(proportion*nrow(car)))
train_car<-car[index,]
test_car<-car[-index,]
head(train_car)
head(test_car)

NROW(train_car)
NROW(test_car)

car_n<-neuralnet(Audi+ BMW+ Chevrolet+ Datsun+ Fiat+Force~
                   Mileage_Kmpl+Engine_Cc+Power_Bhp+Company_Price_L,
                 train_car,hidden = c(3))
plot(car_n)

pred_test<-compute(car_n,test_car[,11:16])
predtestresult<-pred_test$net.result
predtestresult<as.data.frame(predtestresult)

colnames(predtestresult)<-c("Audi","BMW","Datsun","Chevrolet","Fiat","Force")







 



# Random sampling
samplesize = 0.60 * nrow(data)
set.seed(80)
index = sample( seq_len ( nrow ( data ) ), size = samplesize )

# Create training and test set
datatrain = data[ index, ]
datatest = data[ -index, ]


## Scale data for neural network

max = apply(data , 2 , max)
min = apply(data, 2 , min)
scaled = as.data.frame(scale(data, center = min, scale = max - min))


## Fit neural network 

# install library
install.packages("neuralnet ")

# load library
library(neuralnet)

# creating training and test set
trainNN = scaled[index , ]
testNN = scaled[-index , ]

# fit neural network
set.seed(2)
NN = neuralnet(rating ~ calories + protein + fat + sodium + fiber, trainNN, hidden = 3 , linear.output = T )

# plot neural network
plot(NN)




###final neural
# load library
library(neuralnet)

###nural net 3
data <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv", header=T)
head(data)
as<-data[,-c(2,3,4,5,6,8,9,10,1)]
head(as)
str(as)

hist(as$Selling_Price_L)

dim(as)

##scaling
maxvalue <- apply(as,2,max)
minvalue <- apply(as,2,min)


dataframe<-as.data.frame(scale(as,center =minvalue,scale=maxvalue-minvalue))

ind<-sample(1:nrow(dataframe),3500)
trainDf <- dataframe[ind,]
testDf<-dataframe[-ind,]
  

allvars<-colnames(dataframe)
predictorvars<-allvars[!allvars%in%"Selling_Price_L"]
predictorvars<-paste(predictorvars,collapse = "+")
form=as.formula(paste("Selling_Price_L~",predictorvars,collapse = "+"))
neuralModel<-neuralnet(formula = form,
                       hidden = c(2),linear.output = T,
                       data=trainDf)


plot(neuralModel)


prdeictions<-neuralnet::compute(neuralModel,testDf[,1:6])
str(prdeictions)


prdeictions<-prdeictions$net.result*(max(testDf$Selling_Price_L)-min(testDf$Selling_Price_L))+min(testDf$Selling_Price_L )
actualvalues<-(testDf$Selling_Price_L)*(max(testDf$Selling_Price_L)-min(testDf$Selling_Price_L))+min(testDf$Selling_Price_L )

MSE<-sum((prdeictions-actualvalues)^2)/nrow(testDf)
MSE
 
library(plotly)

# plot(testDf$Selling_Price_L,prdeictions,col="blue",main="real vs predicted",pch=1,cex=0.9,type = "p",
#      xlab = "Actual",ylab = "predicted")
# 
# abline(0,1,col="black")

p <-ggplot(testDf, aes(Selling_Price_L,prdeictions)) +
  geom_point(colour = "indianred1", size = .5 )+
  stat_smooth(method = lm)+
  theme(panel.background = element_rect(fill = "grey96"),
        panel.grid.major = element_line(colour = "grey90"),
        axis.text.x = element_text(angle=-40),
        axis.line = element_line(size =1, colour = "grey40") ,
        axis.ticks = element_line(size = 1.3))+
  labs(title = "VS PLOT", 
       x="Actual",
       y="predicted")

ggplotly(p)



