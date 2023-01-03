library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput("dataset", label = "Dataset",
               choices = datasets),
  verbatimTextOutput("summary"), ##########
  plotOutput("plot") ##########
)

# fluidPage에서의 Input이나 Output의 변수는 "동일한" 것이다.
# 따라서 변수명을 확실히 동일하게 지정해야함 -- 철자 틀리면 안 됨
# output/input in server and fluidPage

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })

  output$summary <- renderPrint({ #######
    summary(dataset())
  })
  output$plot <- renderPlot({ #########
    plot(dataset())
  }, res = 96)
}

shinyApp(ui, server)

shiny::runApp()