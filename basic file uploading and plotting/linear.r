cardata <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
head(cardata)
pairs(cardata[2:16])

#multiple linear regression
results <- lm(Selling_Price_L~Company_Price_L+Kilometers_Driven,cardata)
results
summary(results)


results <- lm(Purchase_Price_L~Company_Price_L,cardata)
results
summary(results)

reduce <- lm(Purchase_Price_L~Company_Price_L,cardata)
full <- lm(Purchase_Price_L~Company_Price_L,cardata)
anova(reduce,full)

predict(results,data.frame(Company_Price_L=10.41,Engine_Cc=1248),interval = "confidence")

##for exp
reduce <- lm(Selling_Price_L~Company_Price_L+Kilometers_Driven,cardata)
full <- lm(Selling_Price_L~Company_Price_L+Kilometers_Driven,cardata)
anova(reduce,full)

predict(results,data.frame(Company_Price_L=8.61,Kilometers_Driven=46000),interval = "confidence")






results <- lm(Company_Price_L~Power_Bhp+Engine_Cc,cardata)
results
summary(results)


predict(results,data.frame(Power_Bhp=73,Engine_Cc=1196),interval = "confidence")


plot(cardata$Company_name, cardata$Engine_Cc+cardata$Power_Bhp, xlab = "Wins", ylab = "Goals & Clean Sheets", main = "Factor 1 - Wins vs Goals & Clean Sheets")
