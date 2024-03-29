
shinyUI(fluidPage(
  bootstrapPage(theme = "xapstyles.css",
                tags$head(tags$style(
                  HTML("
                       .shiny-output-error { visibility: hidden; }
                       ")
                  )),
                
                headerPanel("t-Test"),
                mainPanel(width = 12,
                          tabsetPanel(
                            tabPanel('Data view',
                                     fluidPage(
                                       
                                                        sidebarLayout(
                                                          sidebarPanel(
                                                            xap.chooseDataTableUI("choose_data", label = "choose a dataset"),
                                                            tags$hr(),
                                                            checkboxInput('header', 'header', TRUE),
                                                            radioButtons(
                                                              'sep', 'separator',
                                                              c(comma = ',', semicolon=';', tab='\t'),
                                                              selected = ','
                                                            ),
                                                            radioButtons(
                                                              'quote', 'quote',
                                                              c(none = '', 'double quote' = '"', 'single quote' = "'"),
                                                              selected = '"'
                                                            )
                                                            
                                                            
                                                          ),
                                                          
                                                          
                                                          mainPanel(
                                                            
                                                            conditionalPanel(
                                                              
                                                              condition = "input['choose_data-table_name'] == ''",
                                                              h2("Please select a dataset")
                                                              
                                                              
                                                            ),
                                                            conditionalPanel(
                                                              
                                                              condition = "input['choose_data-table_name'] != ''",
                                                              h2("Data summary"),
                                                              verbatimTextOutput('disc'),
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              h2("Data structure"),
                                                              verbatimTextOutput('str') 
                                                              #,
                                                              
                                                              #h2("Data table"),
                                                              #DT::dataTableOutput('contents')
                                                            
                                                          ))      
                                       ))),           
                            tabPanel('t-Test',
                                     fluidPage(
                                       
                                         sidebarLayout(
                                           sidebarPanel(
                                             h3("Variable selection"),
                                             radioButtons("sample",
                                                          "Please choose one sample t-test or two sample t-test:",
                                                          choices = c("One sample" = "oneSamp", 
                                                                      "Two sample" = "twoSamp")),
                                             chooseNumericColumnUI("num_col"),
                                             
                                             conditionalPanel(condition = "input.sample == 'twoSamp'",
                                                              chooseColumnUI("cat_col"),
                                                              chooseValueUI("cat1"),
                                                              chooseValueUI("cat2")
                                             ),
                                             hr(),
                                             h3("Plot controls"),
                                             ggplotDensityCompareInput("plot"),
                                             hr(),
                                             h3("Test controls"),
                                             selectInput("tail",
                                                         label = "Please select a relationship you want to test:",
                                                         choices = c("two-tailed" = "two.sided", 
                                                                     "one-tailed (less)" = "less",
                                                                     "one-tailed (greater)" = "greater")
                                             ),
                                             conditionalPanel(condition = "input.sample == 'oneSamp'",
                                                              numericInput("test", "Mean value you want to test",
                                                                           value = 0
                                                              )
                                             ),
                                             conditionalPanel(condition = "input.sample == 'twoSamp'",
                                                              radioButtons("varequal",
                                                                           "Do the two samples have equal variance:",
                                                                           choices = c("yes" = "y", "no" = "n")
                                                              )
                                             ),
                                             numericInput("conf",
                                                          label = "Select a confidence level:",
                                                          value = 0.95,
                                                          min = 0.8,
                                                          max = 0.99
                                             ),
                                             helpText("Note: assign a number between 0.8 and 0.99")
                                             
                                             
                                           ),
                                           
                                           
                                           mainPanel(
                                             
                                             plotOutput('graph'),
                                             
                                             h2("Key summary statistics"),
                                             p("The observed sample statistics were:"),
                                             tableOutput('parametric'),
                                             h2("Hypothesis of the t-test"),
                                             p("We are testing the null hypothesis that the mean of population equals to the value you set, or in the two-sample
                                               case that the mean of both populations is the same."),
                                             p("The observed t test statistic :"),
                                             p("t=",textOutput('tvalue', inline = TRUE)),
                                             p("The P value from the test is compared to your selected threshold, which is (1 - confidence level)."),
                                             p("If your P value is below the threshold, the null hypothesis rejected."),
                                             h3("P=", textOutput('pvalue', inline = TRUE)),
                                             h4(textOutput("sigtext"))
                                             
                                             
                                             
                                             )
                                       ))),
                            
                            documentation_tab()
                          )
                          
                          
                          
                )
                  )
  
                ))