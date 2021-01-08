library(shiny)
library(shinyFeedback)
library(ggplot2)
library(tibble)
library(ggthemes)
library(thematic)


# Random walk helpers
is.naturalnumber <-
  function(x, tol = .Machine$double.eps^0.5)  x > tol & abs(x - round(x)) < tol

# Automatic theming of the app
ggplot2::theme_set(ggplot2::theme_minimal())
thematic::thematic_shiny(font = "auto")