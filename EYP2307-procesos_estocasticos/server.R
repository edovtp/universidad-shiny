# Main server function

server <- function(input, output, session) {
  # Tab panel switcher ----
  observe({
    req(input$select)
    updateTabsetPanel(session, "parameters_tab", input$select)}
  )
  
  # Random walk ----
  random_walk <- reactiveVal(NULL)
  
  observeEvent(input$rw_start, {
    # Input validation
    # TODO Existing values
    
    # Correct values
    prob <-  0 <= input$rw_prob & input$rw_prob <= 1
    natural <- is.naturalnumber(input$rw_length)
    
    shinyFeedback::feedbackWarning(
      "rw_prob",
      !prob,
      "Ingrese una probabilidad válida"
    )
    
    shinyFeedback::feedbackWarning(
      "rw_length",
      !natural,
      "Ingrese un largo válido para la cadena"
    )
    
    # Random walk computation
    req(prob, natural)
    time <- c(0, seq_len(input$rw_length)) 
    x <- c(0, sample(c(-1, 1), input$rw_length,
                replace = TRUE, prob = c(1 - input$rw_prob, input$rw_prob)))
    y <- cumsum(x)
    random_walk(tibble::tibble(time, x, y))
  })
  
  # Random walk static graphic ----
  rw_static <- reactive({
    colourblind_cols <- ggthemes::colorblind_pal()(3)
    
    req(random_walk())
    
    ggplot(random_walk(), aes(time, y)) +
      geom_hline(yintercept = 0, col = colourblind_cols[3]) +
      geom_line(col = colourblind_cols[2]) +
      labs(title = "Visualización de la caminata aleatoria",
           x = "Tiempo", y = "Y")
  })
  
  # Random walk dynamic graphic ----
  rw_dynamic <- reactive({
    # TODO dynamic graphic gganimate
    "graficooooo"
  })
  
  # Random walk graphic
  output$results <- renderPlot({
    rw_static()
  }, res = 96)
}