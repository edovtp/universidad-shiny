library(shiny)
library(shinyFeedback)


implementado <- c("Caminata aleatoria")

# UI implementation
ui <- fluidPage(
  titlePanel(strong("EYP2307 - Procesos Estocásticos")),
  br(),
  sidebarLayout(
    sidebarPanel(
      selectInput("select", "Visualización",
                  choices = c("", implementado)),
      br(),
      uiOutput("parameters")
    ),
    mainPanel(
      uiOutput("results")
    )
  )
)

server <- function(input, output, session) {
  # Parameter inputs creator
  parameters_ui <- reactive({
    req(input$select)
    if (input$select == "Caminata aleatoria"){
      list(
        numericInput("rw_prob", "p", min = 0, max = 1,
                     step = 0.1, value = 0.5),
        numericInput("rw_size", "n", min = 1, step = 1, value = 50),
        # sliderInput("rw_time", "Tiempo", min = 0.01, max = 10, value = 0.5),
        actionButton("rw_start", "Simular"),
        br(),br(),
        # actionButton("rw_stop", "Detener")
      )
    }
  })
  
  # Parameter inputs sender
  output$parameters <- renderUI({
    req(input$select)
    tagList(
      parameters_ui()
    )
  })
  
  # Random walk
  observeEvent(input$rw_start, {
    
  })
}


shinyApp(ui, server)