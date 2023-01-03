setwd("C:/WORK/R/shiny/01/exercise")

library(shiny, help, pos = 2, lib.loc = NULL)

ui <- fluidPage(
  numericInput("age", "How old are you?", value = NA),
  textInput("name", "What's your name?"),
  textOutput("greeting"),
  tableOutput("mortgage") # table
)

# specifying the behaviour of the app 

# this is giving a recipe to Shiny
server <- function(input, output, session){

    output$greeting <- renderText({
    paste0("Hello ", input$name)
    })

    output$histogram <- renderPlot({
    hist(rnorm(1000))
    }, res = 96)
}

# Construct and Start Shiny app
shinyApp(ui, server)

shiny::runApp()