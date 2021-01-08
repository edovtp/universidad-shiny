# Variables ----
implementado <- c("Caminata aleatoria" = "random_walk")

# Random walk parameter tab constructor ----

ui_random_walk <- tabPanel(
  "random_walk",
  numericInput("rw_prob", "p", min = 0, max = 1,
               step = 0.1, value = 0.5),
  numericInput("rw_length", "n", min = 1, step = 1, value = 1000),
  actionButton("rw_start", "Simular")
)

# Main ui ----
ui <- fluidPage(
  theme = shinythemes::shinytheme("sandstone"),
  shinyFeedback::useShinyFeedback(),
  # Ver referencias [1]
  tags$head(tags$style(".shiny-plot-output{height:70vh !important;}")),
  # Ver referencias [2]
  tags$head(tags$style(".shiny-image-output img {width: 100%; height: 70vh}")),
  titlePanel("EYP2307 - Procesos Estocásticos"),
  br(),
  sidebarLayout(
    sidebarPanel(
      selectInput("select", "Visualización",
                  choices = c("", implementado)),
      br(),
      tabsetPanel(
        id = "parameters_tab",
        type = "hidden",
        tabPanel("empty"),
        ui_random_walk
      )
    ),
    mainPanel(
      uiOutput("results")
    )
  )
)