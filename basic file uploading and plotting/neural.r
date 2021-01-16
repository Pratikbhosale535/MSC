ui:-
  #  menuItem("NEURAL NETWORK", tabName = "neural", icon = icon("brain"))  
  
  # ,
  # tabItem(tabName = "neural",
  #         tabsetPanel(type = "tabs",
  #                     tabPanel("PLOT", plotlyOutput("neural1",height = 560)),
  #                     tabPanel("SUMMARY", verbatimTextOutput("neuralsum"))
  #         )
  #         )


Server:-
# ###NEURAL NETWORK
#     output$neural1<-renderPlotly({
#       inFile <- input$file1
#       set.seed(123)
#       data <- read.csv(inFile$datapath, header = input$header)
#       as<-data[,-c(2,3,4,5,6,8,9,10,1)]
#       # head(as)
#       # str(as)
#       # 
#       # hist(as$Selling_Price_L)
#       
#     #  dim(as)
#       
#       ##scaling
#       maxvalue <- apply(as,2,max)
#       minvalue <- apply(as,2,min)
#       
#       
#       dataframe<-as.data.frame(scale(as,center =minvalue,scale=maxvalue-minvalue))
#       
#       ind<-sample(1:nrow(dataframe),3500)
#       trainDf <- dataframe[ind,]
#       testDf<-dataframe[-ind,]
#       
#       
#       allvars<-colnames(dataframe)
#       predictorvars<-allvars[!allvars%in%"Selling_Price_L"]
#       predictorvars<-paste(predictorvars,collapse = "+")
#       form=as.formula(paste("Selling_Price_L~",predictorvars,collapse = "+"))
#       neuralModel<-neuralnet(formula = form,
#                              hidden = c(2),linear.output = T,
#                              data=trainDf)
#       
#       
#       plot(neuralModel)
#       
#       
#       prdeictions<-neuralnet::compute(neuralModel,testDf[,1:6])
#    #   str(prdeictions)
#       
#       
#       prdeictions<-prdeictions$net.result*(max(testDf$Selling_Price_L)-min(testDf$Selling_Price_L))+min(testDf$Selling_Price_L )
#       actualvalues<-(testDf$Selling_Price_L)*(max(testDf$Selling_Price_L)-min(testDf$Selling_Price_L))+min(testDf$Selling_Price_L )
#       
#       MSE<-sum((prdeictions-actualvalues)^2)/nrow(testDf)
#    #   MSE
#       
#       
#       # plot(testDf$Selling_Price_L,prdeictions,col="blue",main="real vs predicted",pch=1,cex=0.9,type = "p",
#       #      xlab = "Actual",ylab = "predicted")
#       # 
#       # abline(0,1,col="black")
#       
#       p <-ggplot(testDf, aes(Selling_Price_L,prdeictions)) +
#         geom_point(colour = "indianred1", size = .5 )+
#         stat_smooth(method = lm)+
#         theme(panel.background = element_rect(fill = "grey96"),
#               panel.grid.major = element_line(colour = "grey90"),
#               axis.text.x = element_text(angle=-40),
#               axis.line = element_line(size =1, colour = "grey40") ,
#               axis.ticks = element_line(size = 1.3))+
#         labs(title = "Predicted Vs Actual PLOT", 
#              x="Actual",
#              y="predicted")
#       
#       ggplotly(p)
#     })
# 
# ###neural summary
#     output$neuralsum <- renderPrint({
#       inFile <- input$file1
#       a <- read.csv(inFile$datapath, header = input$header)
#       set.seed(123)
#       data <- read.csv(inFile$datapath, header = input$header)
#       as<-data[,-c(2,3,4,5,6,8,9,10,1)]
#       # head(as)
#       # str(as)
#       # 
#       # hist(as$Selling_Price_L)
#       
#       #  dim(as)
#       
#       ##scaling
#       maxvalue <- apply(as,2,max)
#       minvalue <- apply(as,2,min)
#       
#       
#       dataframe<-as.data.frame(scale(as,center =minvalue,scale=maxvalue-minvalue))
#       
#       ind<-sample(1:nrow(dataframe),3500)
#       trainDf <- dataframe[ind,]
#       testDf<-dataframe[-ind,]
#       
#       
#       allvars<-colnames(dataframe)
#       predictorvars<-allvars[!allvars%in%"Selling_Price_L"]
#       predictorvars<-paste(predictorvars,collapse = "+")
#       form=as.formula(paste("Selling_Price_L~",predictorvars,collapse = "+"))
#       neuralModel<-neuralnet(formula = form,
#                              hidden = c(2),linear.output = T,
#                              data=trainDf)
#       
#       
#      # plot(neuralModel)
#       
#       
#       prdeictions<-neuralnet::compute(neuralModel,testDf[,1:6])
#     #  str(prdeictions)
#       
#       
#       prdeictions<-prdeictions$net.result*(max(testDf$Selling_Price_L)-min(testDf$Selling_Price_L))+min(testDf$Selling_Price_L )
#       actualvalues<-(testDf$Selling_Price_L)*(max(testDf$Selling_Price_L)-min(testDf$Selling_Price_L))+min(testDf$Selling_Price_L )
#       
#       MSE<-sum((prdeictions-actualvalues)^2)/nrow(testDf)
#       MSE
#     })