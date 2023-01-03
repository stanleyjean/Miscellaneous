library(shiny)

ui <- fluidPage(
    # 1
    textInput("tt", "Type your name", placeholder = "Your name"),

    # 2
    sliderInput("dateslide", "When should we deliver?",
                        min = as.Date("2020-09-16","%Y-%m-%d"),
                        max = as.Date("2020-09-23","%Y-%m-%d"),
                        value = as.Date("2020-09-17"),
                        timeFormat = "%Y-%m-%d"),

    # 3
    sliderInput("values", "0 to 100", 
                    min = 0,
                    max = 100,
                    value = 0,
                    step = 5, animate = animationOptions(interval = 500)),

    # 4
    # use selectize input function ?
    

)

server <- function(input, output, session){

}

shinyApp(ui, server)

shiny::runApp()