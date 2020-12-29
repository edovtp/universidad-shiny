server <- function(input, output, session) {
  # Tab panel switcher
  observe({
    req(input$select)
    updateTabsetPanel(session, "parameters_tab", input$select)}
  )
  
  # Random walk
  random_walk <- reactiveVal(NULL)
  
  observeEvent(input$rw_start, {
    # Validación de inputs
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
    
    req(prob, natural)
    x <- sample(c(-1, 1), input$rw_length,
                replace = TRUE, prob = c(1 - input$rw_prob, input$rw_prob))
    y <- cumsum(x)
    random_walk(y)
  })
  
  output$results <- renderPrint({
    req(random_walk())
    random_walk()
  })
}