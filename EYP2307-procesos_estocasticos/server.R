server <- function(input, output, session) {
  # Tab panel switcher
  observe({
    req(input$select)
    updateTabsetPanel(session, "parameters_tab", input$select)}
  )
  
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