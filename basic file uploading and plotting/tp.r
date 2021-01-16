a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
head(a)

library(ggplot2)
theme_set(theme_classic())

# Source: Frequency table
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
head(a)
colnames(a) <- c("Company_name", "freq")
pie <- ggplot(a, aes(x = "", y=freq, fill = factor(Company_name))) + 
  geom_bar(width = 1, stat = "identity") +
  theme(axis.line = element_blank(), 
        plot.title = element_text(hjust=0.5)) + 
  labs(fill="Company_name", 
       x=NULL, 
       y=NULL, 
       title="Pie Chart of Company_name")

pie + coord_polar(theta = "y", start=0)



######Yearwise pie chart
library(plotly)
a <- read.csv(file="F:\\PRATIK\\cardata.csv")

#data <- data.frame(a$Company_name,a$Year)
#print(data)

b <- subset( a, Year=="2016")
head(b)

p <- plot_ly(b, labels = ~Location,  type = 'pie') %>%
  layout(title = 'United States Personal Expenditures by Categories in 1960',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

p


library(plotly)
a <- read.csv(file="F:\\PRATIK\\cardata.csv")
b <- subset( a, Company_name=="Maruti Suzuki")
l <- b[,c(11,13)]
 head(l)

d <- aggregate(l,list(Model_Name=b$Model_Name), mean)
 head(b)
 print(b)
p <- plot_ly(d, x = ~Model_Name, y = ~Power_Bhp, type = 'bar', name = 'Power_Bhp')%>%
  add_trace(d, x = ~Model_Name, y = ~Mileage_Kmpl,type = 'scatter', mode = 'lines+markers',name = 'Mileage_Kmpl')%>%
  layout( title = "Average Power(Bhp) and mileage(Kmpl) Across Models ",
          xaxis = list(title = "Model_Name"), yaxis = list(title = "Average Power(Bhp) and mileage(Kmpl)") 
  )
ggplotly(p)

###donut chart
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- subset( a, Year=="2010")
p <- b %>%
  group_by(Company_name) %>%
  summarize(count = n()) %>%
  plot_ly(labels = ~Company_name,values = ~count) %>%
  add_pie(hole = 0.4) %>%
  layout(title = "Donut charts using Plotly",  
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
p




###cluster
library(plotly)

#d <- diamonds[sample(nrow(diamonds), 1000), ]
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
p <- plot_ly(data = a, x = ~Mileage_Kmpl, y= ~Power_Bhp,color = ~Company_name,
             text = ~paste('Mileage:',Mileage_Kmpl,'Kmpl<br>Power:' , Power_Bhp, 'Bhp<br>Company name:', Company_name,'<br>Model name:',Model_Name)
             )
p

a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
p <- plot_ly(a, x = ~Company_name, y= ~Location,color = ~Company_name,
             text = ~paste('Company_name:',Company_name,'Kmpl<br>Location:' , Location,
                           '<br>Model name:',Sub_Model_Name)
)%>%
  layout(title ='Scatter Plot:Location VS Company_name')
p

library(ggplot2)

library(plotly)
theme_set(theme_classic())
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
# Histogram on a Categorical variable
g <- ggplot(a, aes(Company_name))
g + geom_bar(aes(fill=Transmission), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title="Histogram on Categorical Variable", 
       subtitle="Manufacturer across Vehicle Classes") 



library(plotly)
a <- read.csv(file="D:\\a study\\Msc.Part 3\\BID\\MiniProj\\bookdata.csv")
p <- ggplot(data=a,aes(x=book_id,y=No_Of_Times_book_Issued ))
p <- p + geom_bar(stat = "identity",fill="steelblue")  + 
  #ylim(0,120)+
  theme(axis.text.x = element_text(angle=-40)
        #  axis.text.y = element_text(face="bold"),
        # axis.title.x=element_text(size=11),  # X axis title
        # axis.title.y=element_text(size=11,face="bold"),
        # plot.subtitle=element_text(size=13, face="bold")
  )  +
  labs( y="COUNT",
        x="Book Category")
ggplotly(p)



##histogrammm
a <- read.csv(file="D:\\a study\\Msc.Part 3\\BID\\MiniProj\\bookdata.csv")
# Histogram on a Categorical variable
g <- ggplot(a, aes(Book_Category))
g + geom_bar(aes(fill=Language_Code), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title="Histogram on Authorwise Lanaguage", 
       subtitle="Languages of") 
ggplotly(g)


##Lollipop chart
library(ggplot2)

a <- read.csv(file="D:\\a study\\Msc.Part 3\\BID\\MiniProj\\bookdata.csv")

# Plot
ggplot(a, aes(x=book_id)) + 
  geom_point(size=3) + 
  geom_segment(aes(x=book_id, 
                   xend=book_id)) + 
  labs(title="Lollipop Chart", 
       subtitle="Make Vs Avg. Mileage", 
       caption="source: mpg") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))


##tBALE OUTPUT
a <- read.csv(file="D:\\a study\\Msc.Part 3\\BID\\MiniProj\\orderbook.csv")


##agregate
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
head(a)
b <- aggregate(a[, 15:16], list(a$Selling_Price_L), mean)
head(b)
summary(b)
p <- plot_ly(b, x = ~Group.1, y = ~Company_Price_L, type = 'bar', name = 'SF Zoo')%>%
  add_trace(y = ~Selling_Price_L, name = 'LA Zoo') 
ggplotly(p)

##plotlyline
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a[, 15:16], list(a$Company_name), mean)
j<-b[,-c(1)]
head(j)
m<-format(j,digits=2, format="f")
head(m)
# head(b)
# print(b)

 d <-(b$Company_Price_L-b$Selling_Price_L)
 n <-(d*100)/b$Company_Price_L
 #head(z)
 x<-format(n,digits=2, format="f")
 head(x)

p <- plot_ly(b, x = ~Group.1, y = ~m$Company_Price_L,type = 'scatter', mode = 'lines+markers',name ='AVERAGE COMPANY PRICE(L)')%>%
  add_trace(y = ~m$Selling_Price_L, type = 'scatter', mode = 'lines+markers',name ='AVERAGE SELLING PRICE(L)')
ggplotly(p)


%>%
  add_trace(y =~x  , type = 'bar' ,name ='AVERAGE % loss',width='5%',color = I("lemonchiffon3")     )



##plotlyline gfgfhjj
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a[, 15:16], list(a$Company_name), mean)
 j<-b[,-c(1)]
# head(j)
 m<-format(j,digits=1, format="f")
 head(m)
# head(b)
# print(b)

d <-(b$Company_Price_L-b$Selling_Price_L)
z <-(d*100)/b$Company_Price_L
#head(z)
 x<-format(z,digits=2, format="f")
# head(x)

p <- plot_ly(b, x = ~Group.1, y = ~Company_Price_L,type = 'scatter', mode = 'lines+markers',name ='AVERAGE COMPANY PRICE(L)')%>%
  add_trace(y = ~Selling_Price_L, type = 'scatter', mode = 'lines+markers',name ='AVERAGE SELLING PRICE(L)')%>%
  add_trace(y =~x  , type = 'bar' ,name ='AVERAGE % loss',width='5%',color = I("lemonchiffon3")     )%>%
layout(
    xaxis = list(
      title = 'Product Code'
    ),
    yaxis = list(
      title = '# of Items in Stock'
    ))

    

ggplotly(p)


%>%
  add_trace(y =~x  , type = 'bar' ,name ='AVERAGE % loss',width='5%',color = I("lemonchiffon3")     )




###rank plot with price
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a[, 15:16], list(a$Company_name), mean)
head(b)
d <-(b$Company_Price_L-b$Selling_Price_L)
head(d)
p <- plot_ly(b, x = ~Group.1, y = ~d, type = 'bar', name = 'SF Zoo',decreasing = TRUE)
ggplotly(p)



##ggplot bar graph with rank
library(ggplot2)
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a[, 15:16], list(a$Company_name), mean)
head(b)
d <-(b$Company_Price_L-b$Selling_Price_L)
head(d)
b$Group.1<- factor(b$Group.1, levels = b$Group.1[order(d)])
b$Group.1
#p <- plot_ly(b, x = ~Group.1, y = ~d, type = 'scatter', mode = 'lines', name = 'SF Zoo')
p <- ggplot(b, aes(x = Group.1, y = d)) + theme_bw() + geom_bar(stat = "identity")
ggplotly(p)


##in percent
library(ggplot2)
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a[, 15:16], list(a$Company_name), mean)
head(b)
d <-(b$Company_Price_L-b$Selling_Price_L)
z <-(d*100)/b$Company_Price_L
head(z)
b$Group.1<- factor(b$Group.1, levels = b$Group.1[order(d)])
b$Group.1
#p <- plot_ly(b, x = ~Group.1, y = ~z, type = 'bar', name = 'SF Zoo',decreasing = TRUE)
p <- ggplot(b, aes(x = Group.1, y = z)) + theme_bw() + geom_bar(stat = "identity")
ggplotly(p)



##line graph with rank
library(ggplot2)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a[,15:16], list(Company_name=a$Company_name), mean)
#print(b)
head(b)
d <-(b$Company_Price_L-b$Selling_Price_L)
head(d)
b$Group.1<- factor(b$Group.1, levels = b$Group.1[order(d)])
b$Group.1
p <-ggplot(b, aes(x=Group.1, y = d, group=1)) +
  geom_line()+
  geom_point()+
  theme_bw()
ggplotly(p)



a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a[,c(7,11,12,13,15,16)], list(Company_name=a$Company_name,Model_Name=a$Model_Name), mean)
print(b)


###agregate lollipop km chart
library(ggplot2)
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a["Engine_Cc"], list(Company_name=a$Company_name), mean)
head(b)
p <-ggplot(b, aes(x=Company_name, y=Engine_Cc)) + 
  geom_point(size=3) + 
  geom_segment(aes(x=Company_name, 
                   xend=Company_name, 
                   y=0, 
                   yend=Engine_Cc)) + 
  labs(title="Avg Engine(cc) Across Companies") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))
ggplotly(p)


###bar chart using ployly
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
b <- aggregate(a["Kilometers_Driven"], list(Company_name=a$Company_name), mean)
head(b)
# p <- plot_ly(a, x = ~Company_name, y = ~Kilometers_Driven, type = 'bar', name = 'SF Zoo')%>%
#   add_trace(b, x = ~Company_name, y = ~Kilometers_Driven,type = 'scatter', mode = 'lines+markers')

p <- plot_ly(b, x = ~Company_name, y = ~Kilometers_Driven, type = 'bar', name = 'Bar Graph')%>%
add_trace(b, x = ~Company_name, y = ~Kilometers_Driven,type = 'scatter', mode = 'lines+markers',name = 'Line Graph')
ggplotly(p)



# 
# p <-ggplot(b)  + 
#   geom_bar(aes(x=Company_name, y=Kilometers_Driven),stat="identity", fill="tan1", colour="sienna3")+
#   geom_line(aes(x=Company_name, y=Kilometers_Driven),stat="identity")

ggplotly(p)

###annimation scator plot
library(plotly)
library(gapminder)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
p <- a %>%
  plot_ly(
    x = ~Mileage_Kmpl, 
    y = ~Power_Bhp, 
    size = ~Power_Bhp, 
    color = ~Company_name, 
    frame = ~Year, 
    text = ~Sub_Model_Name, 
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers'
  )  %>% 
  animation_opts(
    3000, easing = "elastic", redraw = FALSE
  )%>%
  
  layout(
    xaxis = list(
      type = "log"
    )
  )
ggplotly(p)


###scatter 3d
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
p <- plot_ly(a, x = ~Engine_Cc, y = ~Company_name, z = ~Power_Bhp, type = 'scatter3d', mode = 'markers', marker = list(size = 3)) %>%
  layout(title = "3D Scatter plot")
ggplotly(p)


###histogram fuel type
library(plotly)
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
p <- plot_ly(a, x = ~Company_name, color = ~Fuel_Type) %>%
  add_histogram() %>%
  layout(title = "3D Scatter plot",
         xaxis = list(rangemode = "tozero"),
         yaxis = list(rangemode = "nonnegative"))
ggplotly(p)



a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
p <- ggplot(data=a,aes(x=Company_name )) + 
  geom_bar(aes(fill = Fuel_Type),width = 0.4, position = position_dodge(width=0.5)) +  
  theme(legend.position="top", legend.title = 
          element_blank(),axis.title.x=element_blank(), 
        axis.title.y=element_blank())
ggplotly(p)

##DENSITY
g <- ggplot(a, aes(Fuel_Type))
p <- g + geom_density(aes(fill=factor(Fuel_Type)), alpha= 0.6) +
  ylim(0,1.2)+
  theme(panel.background = element_rect(fill = "grey96"),
        panel.grid.major = element_line(colour = "grey90"),
        axis.text.x = element_text(angle=-40),
        axis.line = element_line(size =1, colour = "grey40") ,
        axis.ticks = element_line(size = 1.3))+
  labs(title="Density plot on fuel type",
       
       x="FUEL TYPE",
       #    y="Year",
       fill="# Cylinders")
ggplotly(p)

  


###avg of mileage and power
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
l <- a[,c(11,13)]
   head(l)
   b <- aggregate(l,list(Company_name=a$Company_name), mean)
   head(b)
# p <- plot_ly(a, x = ~Company_name, y = ~Kilometers_Driven, type = 'bar', name = 'SF Zoo')%>%
#   add_trace(b, x = ~Company_name, y = ~Kilometers_Driven,type = 'scatter', mode = 'lines+markers')
p <- plot_ly(b, x = ~Company_name, y = ~Power_Bhp, type = 'bar', name = 'Power_Bhp')%>%
  add_trace(b, x = ~Company_name, y = ~Mileage_Kmpl,type = 'scatter', mode = 'lines+markers',name = 'Mileage_Kmpl')%>%
  layout( title = "Average Power(Bhp) and mileage(Kmpl) Across Companies ",
          xaxis = list(title = "Company_name"), yaxis = list(title = "Average Power(Bhp) and mileage(Kmpl)") 
  )
ggplotly(p)
  
  

###scatter plot form km drive
a <- read.csv(file="C:\\Users\\abc\\Desktop\\Downloads\\used-cars-price-prediction\\cardata.csv")
# ggplot(a, aes(Company_name,Kilometers_Driven)) +
#   geom_point(colour = "indianred1", size = 1.5 )+
#   theme(panel.background = element_rect(fill = "grey96"),
#         panel.grid.major = element_line(colour = "grey90"),
#         axis.text.x = element_text(angle=-40),
#         axis.line = element_line(size =1, colour = "grey40") ,
#         axis.ticks = element_line(size = 1.3))+
#   labs(title = "VS PLOT", 
#        x="COMPANY NAME")
p <- plot_ly(a, x = ~Company_name, y = ~Kilometers_Driven,  color = ~Company_name,type = "box")
p




inFile <- input$file1
a <- read.csv(inFile$datapath, header = input$header)
b <- subset( a, Company_name==input$var1)
g <- b[,c(11,13)]
# head(l)

z <- aggregate(g,list(Model_Name=b$Model_Name), mean)
#  head(b)
p <- plot_ly(z, x = ~Model_Name, y = ~Power_Bhp, type = 'bar', name = 'Power_Bhp')%>%
  add_trace(z, x = ~Model_Name, y = ~Mileage_Kmpl, type = 'scatter', mode = 'lines+markers',name = 'Mileage_Kmpl')%>%
  layout( title = "Average Power(Bhp) and mileage(Kmpl) Across Models ",
          xaxis = list(title = "Model_Name"), yaxis = list(title = "Average Power(Bhp) and mileage(Kmpl)") 
  )
ggplotly(p)
