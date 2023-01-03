library(shiny)

# UI defintion
# layout function 
ui <- fluidPage(
  # input control 
  selectInput("dataset", label = "Dataset", 
              choices = ls("package:datasets")),
  # output controls that tell Shiny
  # where to put rendered output
  verbatimTextOutput("summary"), #source code
  tableOutput("table") # table 
)

# specifying the behaviour of the app 

# this is giving a recipe to Shiny
server <- function(input, output, session){
  
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  # reactive fucntion makes the variable like a method
  output$summary <- renderPrint({
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}

# Construct and Start Shiny app
shinyApp(ui, server)