ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  titlePanel("EYP2307 - Procesos Estocásticos"),
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