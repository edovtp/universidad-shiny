# Main server function

server <- function(input, output, session) {
  # Tab panel switcher ----
  observeEvent(input$select, {
    req(input$select)
    updateTabsetPanel(session, "parameters_tab", input$select)
  })

  # Result panel generator ----
  output$results <- renderUI({
    req(input$select)
    if (input$select == "random_walk"){
      tabsetPanel(
        id = "random_walk_tab",
        type ="tabs",
        tabPanel(
          "Gráfico estático",
          plotOutput("rw_static")
        ),
        tabPanel(
          "Gráfico dinámico",
          imageOutput("rw_dynamic")
        ),
        tabPanel(
          "Cadena",
          dataTableOutput("rw_data")
        )
      )
    }
  })
  
  # Random walk ----
  ## Random walk computation ----
  random_walk <- reactiveVal(NULL)
  
  observeEvent(input$rw_start, {
    ### Input validation ----
    prob_exists = isTruthy(input$rw_prob)
    length_exists = isTruthy(input$rw_length)

    shinyFeedback::feedbackDanger(
      "rw_prob",
      !prob_exists,
      "Ingrese una probabilidad"
    )

    shinyFeedback::feedbackDanger(
      "rw_length",
      !length_exists,
      "Ingrese un largo para la cadena"
    )
    
    req(prob_exists, length_exists)

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
    
    ## Computation ----
    req(prob, natural)
    time <- c(0, seq_len(input$rw_length)) 
    x <- c(0, sample(c(-1, 1), input$rw_length,
                replace = TRUE, prob = c(1 - input$rw_prob, input$rw_prob)))
    y <- cumsum(x)
    random_walk(tibble::tibble(time, x, y))
  })
  
  ## Random walk base plot ----
  rw_base_plot <- function(){
    colourblind_cols <- ggthemes::colorblind_pal()(3)
    
    ggplot(random_walk(), aes(time, y)) +
      geom_hline(yintercept = 0, col = colourblind_cols[3]) +
      geom_line(col = colourblind_cols[2]) +
      labs(title = "Visualización de la caminata aleatoria",
           x = "Tiempo", y = "Y")
  }
  
  ## Random walk static plot----
  output$rw_static <- renderPlot({
    req(random_walk())
    rw_base_plot()
  }, res = 96)

  ## Random walk dynamic plot ----
  rw_dynamic_plot <- reactive({
    req(random_walk())
    
    rw_base_plot() +
      gganimate::transition_reveal(time)
  })
  
  output$rw_dynamic <- renderImage({
    outfile <- tempfile(fileext = ".gif")
    
    gganimate::anim_save(
      "outfile.gif",
      gganimate::animate(rw_dynamic_plot(),
                         renderer = gganimate::gifski_renderer(),
                         res = 96))
    
    list(src = "outfile.gif",
         contentType = "image/gif")
  }, deleteFile = TRUE)
  
  ## Random walk data ----
  
  output$rw_data <- renderDataTable({
    req(random_walk())
    random_walk()
  }, options = list(searching = FALSE, pageLength = 10))
}
