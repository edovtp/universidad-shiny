server <- function(input, output, session) {
  # Parameter inputs definer
  parameters_ui <- reactive({
    req(input$select)
    if (input$select == "Caminata aleatoria"){
      list(
        numericInput("rw_prob", "p", min = 0, max = 1,
                     step = 0.1, value = 0.5),
        numericInput("rw_length", "n", min = 1, step = 1, value = 50),
        actionButton("rw_start", "Simular")
      )
    }
  })
  
  # Parameter inputs creator
  output$parameters <- renderUI({
    req(input$select)
    parameters_ui()
  })
  
  # Random walk
  observeEvent(input$rw_start, {
    # Validación de inputs
    message("\n ... Validando inputs ... \n")
    prob <-  0 <= input$rw_prob && input$rw_prob <= 1
    natural <- is.naturalnumber(input$rw_length)
    
    cat("Es la probabilidad válida?", prob, "\n")
    cat("Es el largo de la cadena válido?", natural, "\n")
    
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
  })
}