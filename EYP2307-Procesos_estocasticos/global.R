library(shiny)
library(shinyFeedback)
library(ggplot2)
library(tibble)
library(ggthemes)
library(thematic)
library(shinycssloaders)


# Automatic theming of the app
ggplot2::theme_set(ggplot2::theme_minimal())
thematic::thematic_shiny(font = "auto")

# Global options for shinycssloaders spinners
options(spinner.color="#8e8c84", spinner.type = 8, spinner.size = 2)

# Random walk helpers
is.naturalnumber <-
  function(x, tol = .Machine$double.eps^0.5)  x > tol & abs(x - round(x)) < tol
