library(shiny)
library(shinydashboard)
library(plotly)

shinyUI<-dashboardPage(
  dashboardHeader(title = "ANALYSIS OF USED CARS",
                  titleWidth = 260),
  dashboardSidebar(
    sidebarMenu(style="font-family:Cambria;
                font-weight: bold;",
      menuItem("HOME", tabName = "HOME", icon = icon("home")),
      menuItem("COMPANY WISE PLOTS", tabName = "PLOT1", icon = icon("chart-bar")),
      menuItem("YEAR WISE", tabName = "widgets", icon = icon("chart-pie")),
      menuItem("MODEL WISE PLOTS", tabName = "model", icon = icon("chart-bar")),
      menuItem("LINEAR REGRESSION", tabName = "lr", icon = icon("chart-line"),
               menuSubItem('POWER VS ENGINE',
                           tabName = 'POWER'),
               menuSubItem('CP VS ENGINE & POWER',
                           tabName = 'SECOND'),
               menuSubItem('CP VS SP',
                           tabName = 'THIRD')
               ),
      menuItem("VS PLOT", tabName = "vs", icon = icon("chart-bar")),
      menuItem("SCATTER PLOTTER", tabName = "scatter", icon = icon("chart-bar")),
      menuItem("K-MEANS CLUSTERING", tabName = "Clustering", icon = icon("chart-area")),
     menuItem("BASED ON PRICE", tabName = "price", icon = icon("rupee-sign"))
 
    )
  ),
  dashboardBody(
    style="color:#665D53;
              font-family:Cambria;
              font-weight: bold;
                 font-size:15;
                text-align:center;"
    ,
    tags$head(tags$style(HTML('
      .main-header .logo {
        font-family:Cambria;
        font-weight: bold;
        font-size: 20px;
      color:blue;
      }
    '))),
    tabItems(
      # First tab content
      tabItem(tabName = "HOME",
              fluidRow(
                box(title="CHOOSE CSV FILE",width = 12,status = "primary",solidHeader = TRUE,collapsible = TRUE,
              icon = icon("file-csv"),
              fileInput("file1","",
                      #  "CHOOSE CSV FILE",
                        accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
              tags$hr(),
              checkboxInput("header", "Header", TRUE),
              placeholder = "No file selected")),
              fluidRow(
                box(title="WORD CLOUD",width = 12,status = "primary",solidHeader = TRUE,collapsible = TRUE,
              plotOutput("plot",height = 430)))
      ),

      tabItem(tabName = "PLOT1",
              # h2("COMPANY WISE TOTAL COUNT",
              #    style="color:#665D53;
              # font-family:Cambria;
              # font-weight: bold;
              #    font-size:15"),
             # plotOutput("plot1")
             tabsetPanel(type = "tabs",
                         tabPanel("COUNTS", plotlyOutput("pl0", height = 560)),
                         tabPanel("KM DRIVEN ", plotlyOutput("pl3",height = 560)),
                         tabPanel("FUEL TYPES", plotlyOutput("pl1",height = 560)),
                         tabPanel("TRANSMISSION", plotlyOutput("pl2",height = 560)),
                         tabPanel("POWER & MILEAGE", plotlyOutput("pl4",height = 560)),
                         tabPanel("ENGINE ", plotlyOutput("plS5",height = 560)),
                         tabPanel("LOCATION", 
                                  fluidRow(column(width = 10,align = "left",box(status = "primary", background = 'light-blue', collapsible = TRUE,
                                             selectizeInput('var', 'SELECT LOCATION ', choices = c("SELECT LOCATION" = "", levels(a$Location ))))))
                                  ,plotlyOutput("pl6",height = 490))
                        
             )
      ),
      # Second tab content
      tabItem(tabName = "widgets",
              h2("YEAR WISE PERCENTAGE OF COMPANY",
                 style="color:#665D53   ;
              font-family:Cambria;
              font-weight: bold;
                 font-size:15"),
              tabsetPanel(type = "tabs",
                          tabPanel("OVERALL", plotlyOutput("OVERALL", height = 520)),
                          tabPanel("2010", plotlyOutput("P2010", height = 520)),
                          tabPanel("2011", plotlyOutput("p2011", height = 520)),
                          tabPanel("2012", plotlyOutput("p2012", height = 520)),
                          tabPanel("2013", plotlyOutput("p2013", height = 520)),
                          tabPanel("2014", plotlyOutput("p2014", height = 520)),
                          tabPanel("2015", plotlyOutput("p2015", height = 520)),
                          tabPanel("2016", plotlyOutput("p2016", height = 520)),
                          tabPanel("2017", plotlyOutput("p2017", height = 520)),
                          tabPanel("2018", plotlyOutput("p2018", height = 520)),
                          tabPanel("2019", plotlyOutput("p2019", height = 520))
                          )

              ),
      tabItem(tabName = "POWER",
              tabsetPanel(type = "tabs",
                          tabPanel("PLOT ", plotlyOutput("plot2", height = 560)),
                          tabPanel("SUMMARY", verbatimTextOutput("summarylinear1"),
                                   verbatimTextOutput("predictlinear1"))
                        #  tabPanel("PREDICT",  verbatimTextOutput("predictlinear1"))
              )
      ),
      tabItem(tabName = "SECOND",
              tabsetPanel(type = "tabs",
                          tabPanel("PLOT ", plotlyOutput("linear2", height = 560)),
                          tabPanel("SUMMARY", verbatimTextOutput("summarylinear2"),
                                   verbatimTextOutput("predictlinear2"))
                         # tabPanel("PREDICT",  verbatimTextOutput("predictlinear2"))
              )
      ),
      tabItem(tabName = "THIRD",
              tabsetPanel(type = "tabs",
                          tabPanel("PLOT ", plotlyOutput("linear3", height = 560)),
                          tabPanel("SUMMARY", verbatimTextOutput("summarylinear3"),
                                   verbatimTextOutput("predictlinear3"))
                           # verbatimTextOutput("predictlinear3")
              )
      ),
                          
      
      tabItem(tabName = "vs",
              # h2("VS PLOT",
              #    style="color:#665D53   ;
              # font-family:Cambria;
              # font-weight: bold;
              #    font-size:15"),
              fluidRow(column(width = 12,
                              box(status = "primary",background = 'light-blue',collapsible = TRUE,
              varSelectInput("X"," X AXIS",a[2])),
              box(status = "primary",background = 'light-blue',collapsible = TRUE,
          varSelectInput("Y", "SELECT Y AXIS", a[5:16])))),
              plotlyOutput("plot3",height = 500)
      ),

      
       tabItem(tabName = "model",
               fluidRow(column(width = 10,align = "left", box(status = "primary",background = 'light-blue',collapsible = TRUE,
              selectizeInput('var1', 'SELECT COMPANY', choices = c("SELECT COMPANY" = "", levels(a$Company_name)))))),
              tabsetPanel(type = "tabs",
                          tabPanel("COUNTS", plotlyOutput("m1", height = 490)),
                          tabPanel("KM DRIVEN", plotlyOutput("m2",height = 490)),
                          tabPanel("FUEL TYPES", plotlyOutput("m3",height = 490)),
                          tabPanel("TRANSMISSION ", plotlyOutput("m4",height = 490)),
                          tabPanel("POWER & MILEAGE", plotlyOutput("m5",height = 490)),
                          tabPanel("ENGINE", plotlyOutput("m6",height = 490)),
                          tabPanel("LOCATION",
                                   fluidRow(column(width = 10,align = "left",
                                                   box(status = "primary", background = 'light-blue',collapsible = TRUE, 
                                                   selectizeInput('var2', 'SELECT LOCATION ', choices = c("SELECT LOCATION" = "", levels(a$Location )))))),
                                  # selectizeInput('var2', 'Select Location ', choices = a$Location ),
                                   plotlyOutput("m7",height = 450))
           #   plotlyOutput("plot34")
)
      ),
      
      
      tabItem(tabName = "scatter",
              # h2("SCATTER PLOT FOR POWER VS MILEAGE",
              #    style="color:#665D53   ;
              # font-family:Cambria;
              # font-weight: bold;
              #    font-size:15"),
              tabsetPanel(type = "tabs",
                          tabPanel("OVERALL : POWER VS MILEAGE", plotlyOutput("oscatter",height = 560)),
                          tabPanel("YEAR WISE : POWER VS MILEAGE", plotlyOutput("ascatter",height = 560)),
                           tabPanel("PRICE", plotlyOutput("price",height = 560)),
                          tabPanel("YEAR WISE : PRICE", plotlyOutput("aprice",height = 560))
              )
            #  plotlyOutput("scatter", height = 500)
              
      ),
      tabItem(tabName = "Clustering",
              # h2("K-MEANS CLUSTER ANALYSIS",
              #    style="color:#665D53   ;
              # font-family:Cambria;
              # font-weight: bold;
              #    font-size:15"),
              tabsetPanel(type = "tabs",
                          tabPanel("CLUSTER PLOT",
                                   fluidRow(column(width = 10,align = "left",box(status = "primary", background = 'light-blue',collapsible = TRUE,
                                   selectizeInput('var5', 'SELECT COMPANY', choices = c("SELECT COMPANY" = "", levels(a$Company_name))))),
                                   plotOutput("Clustering1", height = 520))),
                          tabPanel("SUMMARY", verbatimTextOutput("summarycluster1"))
                          )
              
             #  plotOutput("Clustering", height = 500)
      )  ,

   tabItem(tabName = "price",
           tabsetPanel(type = "tabs",
                       tabPanel("OVERALL COMPANY WISE",plotlyOutput('ocompany', height = 560)),
                       tabPanel("MODEL WISE",
                                fluidRow(column(width = 10,align = "left",box(status = "primary", background = 'light-blue', collapsible = TRUE,
                                selectizeInput('var12', 'SELECT COMPANY', 
                                                            choices = c("SELECT COMPANY" = "", levels(a$Company_name))))))
                                , plotlyOutput("modelwise",height = 450)))
           )

      )
    )
    
)
  






