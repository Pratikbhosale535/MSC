library(shiny)
library(shinydashboard)
library(wordcloud)
library(SnowballC)
library(tm)
library(ggplot2)
library(plotly)
library(dplyr)
library(gapminder)
library(plotly)
library(neuralnet)
library(factoextra)

shinyServer(
    
    function(input, output) {
      
      
      output$plot <- renderPlot({
        inFile <- input$file1
       if (is.null(inFile))
            {
         return(NULL)
       }
####word cloud
       else(inFile =="cardata.csv")
       {
         tweetsDS <- read.csv(inFile$datapath, header = input$header)
         tweetsDS<-data.frame(tweetsDS)
         tweetsDS.Corpus<-Corpus(VectorSource(tweetsDS$Sub_Model_Name))
         tweetsDS.Clean<-tm_map(tweetsDS.Corpus, PlainTextDocument)
         tweetsDS.Clean<-tm_map(tweetsDS.Corpus,tolower)
         tweetsDS.Clean<-tm_map(tweetsDS.Clean,removeNumbers)
         #tweetsDS.Clean<-tm_map(tweetsDS.Clean,removeWords,stopwords("english"))
         tweetsDS.Clean<-tm_map(tweetsDS.Clean,removePunctuation)
         tweetsDS.Clean<-tm_map(tweetsDS.Clean,stripWhitespace)
         tweetsDS.Clean<-tm_map(tweetsDS.Clean,stemDocument)
         wordcloud(words = tweetsDS.Clean, min.freq = 1,max.words=1000, random.order=FALSE,
                   rot.per=0.25 ,colors=brewer.pal(25, "Dark2"))

     }

            })
      
#### bar-CHART Company Wise Total Count
      output$pl0 <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
        p <- ggplot(data=a,aes(x=Company_name ))+
         geom_bar(fill="cornflowerblue", width = 0.8) + 
          ylim(0,1200)+
          theme(panel.background = element_rect(fill = "grey96"),
                panel.grid.major = element_line(colour = "grey90"),
                axis.text.x = element_text(angle=-40),
                axis.line = element_line(size =1, colour = "grey40") ,
                axis.ticks = element_line(size = 1.3)

           )+
           labs(title="Company Wise Total Count", y="COUNT",x="COMPANY NAME")

         ggplotly(p)


       })

      
#### GROUPED BAR CHART Fuel Company Wise Total Count
       output$pl1 <- renderPlotly({
        inFile <- input$file1
        a <- read.csv(inFile$datapath, header = input$header)
        p <- ggplot(data=a,aes(x=Company_name ))+
          geom_bar(aes(fill = Fuel_Type), 
         width =1.2, position = position_dodge(width=0.5))+ 
          ylim(0,800)+
           scale_fill_brewer(palette = "RdBu")+
          theme(panel.background = element_rect(fill = "grey97"),
                panel.grid.major = element_line(colour = "grey90"),
                axis.text.x = element_text(angle=-40),
                axis.line = element_line(size =1, colour = "grey40") ,
                axis.ticks = element_line(size = 1.3)) +
          labs(title="Fuel Types Across Companies",
               y="COUNT",
               x="COMPANY NAME") 
       
        ggplotly(p)
        
       })

       
#### HISTOGRAM transmission     
       output$pl2 <-renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         # Histogram on a Categorical variable
         g <- ggplot(a, aes(Company_name))
         g + geom_bar(aes(fill=Transmission), width = 0.8) + 
           ylim(0,1150)+
           theme(panel.background = element_rect(fill = "grey96"),
                 panel.grid.major = element_line(colour = "grey90"),
         axis.text.x = element_text(angle=-40),
                 axis.line = element_line(size =1, colour = "grey40") ,
                 axis.ticks = element_line(size = 1.3)) +
           labs(title="Transmission Across Companies",
                y="COUNT",
                x="COMPANY NAME") 
      })
       
       
####BOX PLOT km driven
       output$pl3 <-renderPlotly({
       inFile <- input$file1
       a <- read.csv(inFile$datapath, header = input$header)
     
       p <- plot_ly(a, x = ~Company_name, y = ~Kilometers_Driven,  color = ~Company_name,type = "box")%>%
         layout(title ='BOX PLOT :Kilometers Driven(KM) VS Company Name')
       p
       })
       
       
#### BAR & LINE GRAPH Average Power(Bhp) and mileage(Kmpl) Across Companies
       output$pl4 <-renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         l <- a[,c(11,13)]
       #  head(l)
         b <- aggregate(l,list(Company_name=a$Company_name), mean)
        # head(b)
         p <- plot_ly(b, x = ~Company_name, y = ~Power_Bhp, type = 'bar', name = 'Power_Bhp')%>%
           add_trace(b, x = ~Company_name, y = ~Mileage_Kmpl,type = 'scatter', mode = 'lines+markers',name = 'Mileage_Kmpl')%>%
           layout( title = "Average Power(Bhp) and mileage(Kmpl) Across Companies ",
                   xaxis = list(title = "Company_name"), yaxis = list(title = "Average Power(Bhp) and mileage(Kmpl)") 
           )
         ggplotly(p)
       })
       
       
###Avg Engine(cc) Across Companies LOLLIPOP CHART
       output$plS5 <-renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         b <- aggregate(a["Engine_Cc"], list(Company_name=a$Company_name), mean)
         p <-ggplot(b, aes(x=Company_name, y=Engine_Cc)) +
           geom_point(size=3, color="deepskyblue4") +
           geom_segment(aes(x=Company_name,
                            xend=Company_name,
                            y=0,
                            yend=Engine_Cc),color="deepskyblue3") +
           ylim(0,3000)+
           theme(panel.background = element_rect(fill = "grey96"),
                 panel.grid.major = element_line(colour = "grey90"),
                 axis.text.x = element_text(angle=-40),
                 axis.line = element_line(size =1, colour = "grey40") ,
                 axis.ticks = element_line(size = 1.3)
           )+
           labs(title="Avg Engine(cc) Across Companies", y="Avg Engine(cc)",x="COMPANY NAME")
         ggplotly(p)
         
       })
       
       
####  location Company Wise Total Count DONUT
       output$pl6 <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         
         b <- subset( a, Location==input$var)
         p <- b %>%
           group_by(Company_name) %>%
           summarize(count = n()) %>%
           plot_ly(labels = ~Company_name,values = ~count) %>%
           add_pie(hole = 0.4) %>%
           layout(title = "Location wise Count & Percentage",
                  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
         p
         
       })
       
       
       
       
       
#### Overall donut 
       output$OVERALL <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
        # b <- subset( a, Year)
         p <- a %>%
           group_by(Company_name) %>%
           summarize(count = n()) %>%
           plot_ly(labels = ~Company_name,values = ~count) %>%
           add_pie(hole = 0.4) %>%
           layout(title = " Overall Count & Percentage ", showlegend=TRUE, 
                  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
         p
       })
       
#### 2010 donut 
       output$P2010 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Year=="2010")
          p <- b %>%
            group_by(Company_name) %>%
            summarize(count = n()) %>%
            plot_ly(labels = ~Company_name,values = ~count) %>%
            add_pie(hole = 0.4) %>%
            layout(title = "Year 2010 Count & Percentage  ", showlegend=TRUE, 
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
          p
       })

 #### 2011 donut 
       output$p2011 <- renderPlotly({
          inFile <- input$file1
          a<-read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Year=="2011")
          p <- b %>%
            group_by(Company_name) %>%
            summarize(count = n()) %>%
            plot_ly(labels = ~Company_name,values = ~count) %>%
            add_pie(hole = 0.4) %>%
            layout(title = "Year 2011 Count & Percentage", showlegend=TRUE, 
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
          p
       })

 #### 2012 donut
       output$p2012 <- renderPlotly({
          inFile <- input$file1
          a<-read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Year=="2012")
          p <- b %>%
            group_by(Company_name) %>%
            summarize(count = n()) %>%
            plot_ly(labels = ~Company_name,values = ~count) %>%
            add_pie(hole = 0.4) %>%
            layout(title = "Year 2012 Count & Percentage", showlegend=TRUE, 
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
          p
       })

#### 2013 donut
       output$p2013 <- renderPlotly({
          inFile <- input$file1
         a<-read.csv(inFile$datapath, header = input$header)
         b <- subset( a, Year=="2013")
         p <- b %>%
           group_by(Company_name) %>%
           summarize(count = n()) %>%
           plot_ly(labels = ~Company_name,values = ~count) %>%
           add_pie(hole = 0.4) %>%
           layout(title = "Year 2013 Count & Percentage", showlegend=TRUE, 
                  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
         p
       })

#### 2014 donut
       output$p2014 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Year=="2014")
          p <- b %>%
            group_by(Company_name) %>%
            summarize(count = n()) %>%
            plot_ly(labels = ~Company_name,values = ~count) %>%
            add_pie(hole = 0.4) %>%
            layout(title = "Year 2014 Count & Percentage", showlegend=TRUE, 
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
          p
       })
       
 #### 2015 donut
       output$p2015 <- renderPlotly({
          inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         b <- subset( a, Year=="2015")
         p <- b %>%
           group_by(Company_name) %>%
           summarize(count = n()) %>%
           plot_ly(labels = ~Company_name,values = ~count) %>%
           add_pie(hole = 0.4) %>%
           layout(title = "Year 2015 Count & Percentage", showlegend=TRUE, 
                  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
         p
       })
      
#### 2016 donut
       output$p2016 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Year=="2016")
          p <- b %>%
            group_by(Company_name) %>%
            summarize(count = n()) %>%
            plot_ly(labels = ~Company_name,values = ~count) %>%
            add_pie(hole = 0.4) %>%
            layout(title = "Year 2016 Count & Percentage", showlegend=TRUE, 
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
          p
       })

       
#### 2017 donut
       output$p2017 <- renderPlotly({
          inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         b <- subset( a, Year=="2017")
         p <- b %>%
           group_by(Company_name) %>%
           summarize(count = n()) %>%
           plot_ly(labels = ~Company_name,values = ~count) %>%
           add_pie(hole = 0.4) %>%
           layout(title = "Year 2017 Count & Percentage", showlegend=TRUE, 
                  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
         p
       })

#### 2018 donut       
       output$p2018 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Year=="2018")
          p <- b %>%
            group_by(Company_name) %>%
            summarize(count = n()) %>%
            plot_ly(labels = ~Company_name,values = ~count) %>%
            add_pie(hole = 0.4) %>%
            layout(title = "Year 2018 Count & Percentage", showlegend=TRUE, 
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
          p
       })
       
#### 2019 donut
       output$p2019 <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         b <- subset( a, Year=="2019")
         p <- b %>%
           group_by(Company_name) %>%
           summarize(count = n()) %>%
           plot_ly(labels = ~Company_name,values = ~count) %>%
           add_pie(hole = 0.4) %>%
           layout(title = "Year 2019 Count & Percentage", showlegend=TRUE, 
                  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
         p
       })

       
       
#### Linear graph1
       output$plot2 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
       p <-  ggplot(a, aes(x = Engine_Cc, y = Power_Bhp)) +
         ylim(0,600)+
         xlim(0,6000)+
           geom_point(colour = "indianred1", size = .3)+
           stat_smooth(method = lm)+
         theme(panel.background = element_rect(fill = "grey96"),
               panel.grid.major = element_line(colour = "grey90"),
       axis.line = element_line(size =1, colour = "grey40") ,
               axis.ticks = element_line(size = 1.3))+
         labs(title = "Linear regression:Power vs Engine",  y="POWER",
                x="ENGINE")
     
         ggplotly(p)

       
       })

#### summarylinear1
       output$summarylinear1 <- renderPrint({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         model <- lm(Power_Bhp~Engine_Cc, data = a)
         summary(model)
       })
       
 #### predictlinear1
       output$predictlinear1 <- renderPrint({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         results <- lm(Power_Bhp~Engine_Cc,a)
       #  results
        # summary(results)
         
         reduce <- lm(Power_Bhp~Engine_Cc,a)
         full <- lm(Power_Bhp~Engine_Cc,a)
         anova(reduce,full)
         
         predict(results,data.frame(Engine_Cc=998),interval = "confidence")
         
       })
       
       
       
 #### Linear graph2
       output$linear2 <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         p <-  ggplot(a, aes(a$Company_Price_L, a$Engine_Cc+a$Power_Bhp)) +
        #   ylim(0,600)+
       #    xlim(0,6000)+
           geom_point(colour = "indianred1", size = .3)+
           stat_smooth(method = lm)+
           theme(panel.background = element_rect(fill = "grey96"),
                 panel.grid.major = element_line(colour = "grey90"),
                 axis.line = element_line(size =1, colour = "grey40") ,
                 axis.ticks = element_line(size = 1.3))+
           labs(title = "Linear regression:Company price VS Engine&Power ",  y="Engine_Cc+Power_Bhp",x="Company_Price_L")
         ggplotly(p)
       })
       
       #### summarylinear2
       output$summarylinear2 <- renderPrint({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         model <- lm(Company_Price_L~Power_Bhp+Engine_Cc, data = a)
         summary(model)
       })
       
       #### predictlinear2
       output$predictlinear2 <- renderPrint({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         results <- lm(Company_Price_L~Power_Bhp+Engine_Cc, data = a)
         #  results
         # summary(results)
         
         reduce <- lm(Company_Price_L~Power_Bhp+Engine_Cc, data = a)
         full <- lm(Company_Price_L~Power_Bhp+Engine_Cc, data = a)
         anova(reduce,full)
         
         predict(results,data.frame(Power_Bhp=67.04,Engine_Cc=998),interval = "confidence")
         
       })
       
       
       
 #### Linear graph3
       output$linear3 <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         p <-  ggplot(a, aes(a$Selling_Price_L ,a$Company_Price_L)) +
           #   ylim(0,600)+
           #    xlim(0,6000)+
           geom_point(colour = "indianred1", size = .3)+
           stat_smooth(method = lm)+
           theme(panel.background = element_rect(fill = "grey96"),
                 panel.grid.major = element_line(colour = "grey90"),
                 axis.line = element_line(size =1, colour = "grey40") ,
                 axis.ticks = element_line(size = 1.3))+
           labs(title = "Linear regression:  Company price VS Selling price",y="Company price(L)",x="Selling price(L)")
         ggplotly(p)
       })
       
 #### summarylinear3
       output$summarylinear3 <- renderPrint({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         model <- lm(Selling_Price_L~Company_Price_L, data = a)
         summary(model)

       })
       
 #### predictlinear3
       output$predictlinear3 <- renderPrint({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         results <- lm(Selling_Price_L~Company_Price_L, data = a)
         #  results
         # summary(results)
         
         reduce <- lm(Selling_Price_L~Company_Price_L, data = a)
         full <- lm(Selling_Price_L~Company_Price_L, data = a)
         anova(reduce,full)
         
         predict(results,data.frame(Company_Price_L=4.2),interval = "confidence")
         
       })
       
       
       
 #### vs plot
       output$plot3 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
        ggplot(a, aes(!!input$X,!!input$Y)) +
          geom_point(colour = "indianred1", size = 1.5 )+
          theme(panel.background = element_rect(fill = "grey96"),
                panel.grid.major = element_line(colour = "grey90"),
            axis.text.x = element_text(angle=-40),
                axis.line = element_line(size =1, colour = "grey40") ,
                axis.ticks = element_line(size = 1.3))+
          labs(title = "VS PLOT", 
               x="COMPANY NAME")
       })
       
       
       
#### model choose model plot
### M1 plot COUNTS OF MODEL BAR CHART
        output$m1 <- renderPlotly({
        inFile <- input$file1
        a <- read.csv(inFile$datapath)
        b <- subset( a, Company_name==input$var1)
     #   c <-head(b$Model_Name)
        p <- ggplot(b,aes(Model_Name))
        f<- p +geom_bar(fill="cornflowerblue",width = 0.6)+
          theme(panel.background = element_rect(fill = "grey96"),
                panel.grid.major = element_line(colour = "grey90"),
        axis.text.x = element_text(angle=-40),
                axis.line = element_line(size =1, colour = "grey40") ,
                axis.ticks = element_line(size = 1.3))+
          labs(title=" Model Wise Total Count", y="COUNT",x="Model NAME")
        
        ggplotly(f)

        })

        
### M2 plot Km Driven Across MODELS BOX PLOT
        output$m2 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath)
          b <- subset( a, Company_name==input$var1)
       
          p <- plot_ly(b, x = ~Model_Name, y = ~Kilometers_Driven,  color = ~Model_Name,type = "box")%>%
            layout(title ='BOX PLOT :Kilometers Driven(KM) VS Model Name')
          p
        })
        
        
### M3 plot Fuel Types Across Models HISTOGRAM
        output$m3 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Company_name==input$var1)
          p <- ggplot(b,aes(x=Model_Name ))+
            geom_bar(aes(fill = Fuel_Type), 
                     width =1.2, position = position_dodge(width=0.5))+ 
          #  ylim(0,800)+
            scale_fill_brewer(palette = "Paired")+
            theme(panel.background = element_rect(fill = "grey97"),
                  panel.grid.major = element_line(colour = "grey90"),
                  axis.text.x = element_text(angle=-40),
                  axis.line = element_line(size =1, colour = "grey40") ,
                  axis.ticks = element_line(size = 1.3)) +
            labs(title="Fuel Types Across Models",
                 y="COUNT",
                 x="Model NAME") 
          ggplotly(p)
        })
        
        
### M4 plot HISTOGRAM transmission Across Models
        output$m4 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          # Histogram on a Categorical variable
          b <- subset( a, Company_name==input$var1)
          g <- ggplot(b, aes(Model_Name))
          g + geom_bar(aes(fill=Transmission), width = 0.8) + 
          #  ylim(0,1150)+
            theme(panel.background = element_rect(fill = "grey96"),
                  panel.grid.major = element_line(colour = "grey90"),
                  axis.text.x = element_text(angle=-40),
                  axis.line = element_line(size =1, colour = "grey40") ,
                  axis.ticks = element_line(size = 1.3)) +
            labs(title="Transmission Across Models",
                 y="COUNT",
                 x="Model NAME") 
        })
        
        
### M5 plot mileage and power Across Models LINE AND BAR
        output$m5 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Company_name==input$var1)
          c <- aggregate(b[,c(11,13)], list(Model_Name=b$Model_Name), mean)
          
          p <- plot_ly(c, x = ~Model_Name, y = ~Power_Bhp, type = 'bar', name = 'Power_Bhp')%>%
            add_trace(c, x = ~Model_Name, y = ~Mileage_Kmpl, type = 'scatter', mode = 'lines+markers',name = 'Mileage_Kmpl')%>%
            layout( title = "Average Power(Bhp) and mileage(Kmpl) Across Models ",
                    xaxis = list(title = "Model_Name"), yaxis = list(title = "Average Power(Bhp) and mileage(Kmpl)") 
            )
          ggplotly(p)
        })
        
        
### M6 plot ENGINE Across Models LOLLIPOP
        output$m6 <- renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Company_name==input$var1)
          c <- aggregate(b["Engine_Cc"], list(Model_Name=b$Model_Name), mean)
          p <-ggplot(c, aes(x=Model_Name, y=Engine_Cc)) +
            geom_point(size=3, color="deepskyblue4") +
            geom_segment(aes(x=Model_Name,
                             xend=Model_Name,
                             y=0,
                             yend=Engine_Cc),color="deepskyblue3") +

            theme(panel.background = element_rect(fill = "grey96"),
                  panel.grid.major = element_line(colour = "grey90"),
                  axis.text.x = element_text(angle=-40),
                  axis.line = element_line(size =1, colour = "grey40") ,
                  axis.ticks = element_line(size = 1.3)
            )+
            labs(title="Avg Engine(cc) Across Models", y="Avg Engine(cc)",x="Model NAME")
          ggplotly(p)
        })
        
        
####  location model Wise Total Count DONUT CHART
        output$m7<-renderPlotly({
          inFile <- input$file1
          a <- read.csv(inFile$datapath, header = input$header)
          b <- subset( a, Company_name==input$var1)
         # print(b)
          d <- subset( b, Location==input$var2)
       #   print(d)
          p <- d %>%
            group_by(Model_Name) %>%
            summarize(count = n()) %>%
            plot_ly(labels = ~Model_Name,values = ~count) %>%
            add_pie(hole = 0.4) %>%
            layout(title = "Location wise Count & Percentage",
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
          p
        })
        

       
       
#### scatter plot  1
       output$oscatter <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         p <- plot_ly(a, x = ~Mileage_Kmpl, y= ~Power_Bhp,color = ~Company_name,
                      text = ~paste('Mileage:',Mileage_Kmpl,'Kmpl<br>Power:' , Power_Bhp,
                                    'Bhp<br>Company name:', Company_name,'<br>Model name:',Sub_Model_Name)
         )%>%
           layout(title ='Scatter Plot:POWER VS MILEAGE')
         p
       })
##animated scatter plot   1    
       output$ascatter <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         p <- a %>%
           plot_ly(
             x = ~Mileage_Kmpl, 
             y = ~Power_Bhp, 
             size = ~Power_Bhp, 
             color = ~Company_name, 
             frame = ~Year, 
             hoverinfo = "text",
             type = 'scatter',
             mode = 'markers',
             text = ~paste('Mileage:',Mileage_Kmpl,'Kmpl<br>Power:' , Power_Bhp, 
              'Bhp<br>Company name:', Company_name,'<br>Model name:',Sub_Model_Name)
           )  %>% 
           animation_opts(
             2500, easing = "elastic", redraw = FALSE
           )%>%
           layout(title ='Year wise Scatter Plot:Power vs Mileage')%>%
           animation_slider(
             currentvalue = list(prefix = "YEAR ", font = list(color="red"))
           )
         ggplotly(p)
       })
       
#### scatter plot  price 2
       output$price <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         p <- plot_ly(a, x = ~Company_Price_L, y= ~Selling_Price_L,color = ~Company_name,
                      text = ~paste('Company Price_L:',Company_Price_L,'L<br>Selling_Price:' , Selling_Price_L,
                                    'L<br>Company name:', Company_name,'<br>Model name:',Sub_Model_Name)
         )%>%
           layout(title ='Scatter Plot:Selling Price(L) VS Company Price(L)')
         p
         
       })
       
       
       ##animated scatter plot   2    
       output$aprice <- renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         p <- a %>%
           plot_ly(
             x = ~Company_Price_L, 
             y = ~Selling_Price_L, 
             size = ~Selling_Price_L, 
             color = ~Company_name, 
             frame = ~Year, 
             hoverinfo = "text",
             type = 'scatter',
             mode = 'markers',
            text = ~paste('Company Price_L:',Company_Price_L,'L<br>Selling_Price:' , Selling_Price_L,
                                         'L<br>Company name:', Company_name,'<br>Model name:',Sub_Model_Name)
           )  %>% 
           animation_opts(
             2500, easing = "elastic", redraw = FALSE
           )%>%
           layout(title ='Year wise Scatter Plot:Company_Price_L vs Selling_Price_L')%>%
           animation_slider(
             currentvalue = list(prefix = "YEAR ", font = list(color="red"))
           )
         ggplotly(p)
       })

       
 ##k means clustering 2
       output$Clustering1 <- renderPlot({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         dat <- a %>% filter(a$Company_name == input$var5 ) %>% select(Model_Name,Mileage_Kmpl,Engine_Cc,Power_Bhp)
        # print(dat)
         d <- data.matrix(dat[-1])
         d1<- na.omit(d)
         d2 <- scale(d1)
         
         #set.seed(123)
         final <- kmeans(d2,4)
        # print(final)
         
         fviz_cluster(final,data = d2)
         #print(cbind(dat,final$cluster))
     

         })

##summarycluster1
       output$summarycluster1 <-  renderPrint({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         dat <- a %>% filter(a$Company_name == input$var5 ) %>% select(Model_Name,Mileage_Kmpl,Engine_Cc,Power_Bhp)
        # print(dat)
         d <- data.matrix(dat[-1])
         d1<- na.omit(d)
         d2 <- scale(d1)
         
         #set.seed(123)
         final <- kmeans(d2,4)
         print(final)
         
         #fviz_cluster(final,data = d2)
        # print(cbind(dat,final$cluster))
         
       })
      
       
###rs COMPANY wise 
       output$ocompany<-renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         b <- aggregate(a[, 15:16], list(Company_name=a$Company_name), mean)
     
         
         d <-(b$Company_Price_L-b$Selling_Price_L)
         z <-(d*100)/b$Company_Price_L
         #head(z)
        # x<-format(z,digits=2, format="f")
         # head(x)
        
         p <- plot_ly(b, x = ~Company_name, y = ~Company_Price_L,type = 'scatter', mode = 'lines+markers',name ='Avg Company Price(L)')%>%
           add_trace(y = ~Selling_Price_L, type = 'scatter', mode = 'lines+markers',name ='Avg Selling Price(L)')%>%
           add_trace(y =~z  , type = 'bar' ,name ='Avg % ',width='5%',color = I("lemonchiffon3")     )%>%
           layout(title='AVERAGE PRICE ANALYSIS(COMPANY WISE( % LOSS FOR SELLER AND PROFIT FOR PURCHASER))',
             xaxis = list(
               title = 'COMPANY NAMES'
             ),
             yaxis = list(
               title = 'AVERAGE PRICE(L) ',
               range = c(0,70)
             ))
       })
       
####rs model wise
       output$modelwise<-renderPlotly({
         inFile <- input$file1
         a <- read.csv(inFile$datapath, header = input$header)
         b <- subset( a, Company_name==input$var12)
         l <- b[,c(15,16)]
         d <- aggregate(l,list(Model_Name=b$Model_Name), mean)

         q <-(d$Company_Price_L-d$Selling_Price_L)
         z <-(q*100)/d$Company_Price_L
      
         p <- plot_ly(d, x = ~Model_Name, y = ~Company_Price_L,type = 'scatter', mode = 'lines+markers',name ='Avg Model Price(L)')%>%
           add_trace(y = ~Selling_Price_L, type = 'scatter', mode = 'lines+markers',name ='Avg Selling Price(L)')%>%
           add_trace(y =~z  , type = 'bar' ,name ='Avg % ',width='5%',color = I("lemonchiffon3")     )%>%
           layout(title='AVERAGE PRICE ANALYSIS(MODEL WISE ( % LOSS FOR SELLER AND PROFIT FOR PURCHASER))',
                  xaxis = list(
                    title = 'MODEL NAMES'
                  ),
                  yaxis = list(
                    title = 'AVERAGE PRICE(L) '
                   
                  ))

         
      })
       
       

           }
        )


