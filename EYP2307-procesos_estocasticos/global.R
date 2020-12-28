# Global helpers
implementado <- c("Caminata aleatoria")

# Random walk helpers
is.naturalnumber <-
  function(x, tol = .Machine$double.eps^0.5)  x > tol & abs(x - round(x)) < tol
