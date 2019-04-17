library(shiny)
library(ggplot2)

# Define UI for application
ui <- fluidPage(
  titlePanel("Investment Model"),
  flowLayout(
    
    sliderInput(inputId = "Amount",
                label = "Initial Amount",
                value = 1000, min = 1, max = 100000,pre = "$", sep = ","),
    sliderInput(inputId = "Return",
                label = "Return Rate (in %)",
                value = 5, min = 0, max = 20),
    sliderInput(inputId = "Time",
                label = "Years",
                value = 10, min = 0, max = 50)),
  
  flowLayout(
    sliderInput(inputId = "Contrib",
                label = "Annual Contribution",
                value = 2000, min = 0, max = 50000,pre = "$", sep = ","),
    sliderInput(inputId = "Growth",
                label = "Growth Rate (in %)",
                value = 2, min = 0, max = 20),
    selectInput("Binary", "Facet?",
                choices = c("No", "Yes"))),
  h4("Timeline"),
  plotOutput("line_graph"),
  h4("Balances"),
  verbatimTextOutput("table")
)


# Define server logic required to draw the plot
server <- function(input, output) {
  
  moda <- reactive({
    future_value <- function(amount, rate, years){
      fv <- amount*((1+rate)^{years})
      return(fv)
    }
    
    annuity <- function(contrib, rate, years){
      fva <- contrib*(((1+rate)^{years}) - 1)/(rate)
      return(fva)
    }
    
    growing_annuity <- function(contrib, rate, growth, years){
      fvga <- contrib*((((1+rate)^{years}) - ((1+growth)^{years}))/(rate- growth))
      return(fvga)
    }
    fv <- rep(0,input$Time)
    new_fva <- rep(0,input$Time)
    new_fvga <- rep(0,input$Time)
    
    for (years in 0:input$Time){
      fv_wo = future_value(input$Amount, input$Return/100, years)
      fv[years+1] = fv_wo
    }
    fv
    
    for (years in 0:input$Time){
      fva_wo = future_value(input$Amount, input$Return/100, years) + annuity(input$Contrib, input$Return/100, years)
      new_fva[years+1] = fva_wo
    }
    new_fva
    
    for (years in 0:input$Time){
      fvga_wo = future_value(input$Amount, input$Return/100, years) + growing_annuity(input$Contrib, input$Return/100, input$Growth/100, years)
      new_fvga[years+1] = fvga_wo
    }
    new_fvga
    
    modalities <- data.frame("year" = c(0:input$Time), "no_contrib" = fv, "fixed_contrib" = new_fva, "growing_contrib" = new_fvga)
    modalities
    
    
  })
  
  
  output$line_graph <- renderPlot({
    library(reshape2)
    mod.melt <- melt(moda(), id.vars = "year")
    if (input$Binary == "Yes") {
      ggplot(data = mod.melt, aes(x = year, y = value, color = variable)) +
        geom_area(aes(fill = variable), alpha = 0.4) +
        geom_point() +
        labs(x = "Years", y = "Money in Bank", title = "Money made with different saving money methods") +
        theme_minimal() +
        scale_color_manual(name = "Modality", values = c("blue", "red", "green")) +
        facet_wrap(.~variable)
      }
    else{
      no_contrib <- moda()$no_contrib
      fixed_contrib <- moda()$fixed_contrib
      growing_contrib <- moda()$growing_contrib
      ggplot(data = moda()) + geom_line(aes(x = year, y = no_contrib, color = "blue")) + geom_line(aes(x = year, y = fixed_contrib, color = "red")) + geom_line(aes(x = year, y = growing_contrib, color = "green")) + theme_bw() + xlab("Years") + ylab("Value") + ggtitle("Three modes of investing") + xlim(0, 10) + ylim(0, 30000) + scale_color_discrete(name = "Key", labels = c("No_Contribution", "Growing_Contribution", "Fixed_Contribution"))
    }
  })
  output$table <- renderPrint({moda()})
  
}


# Run the application 
shinyApp(ui = ui, server = server)
