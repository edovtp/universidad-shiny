library(shiny)
library(shinyFeedback)
library(ggplot2)
library(tibble)
library(ggthemes)


# Random walk helpers
is.naturalnumber <-
  function(x, tol = .Machine$double.eps^0.5)  x > tol & abs(x - round(x)) < tol
