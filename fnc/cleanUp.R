cleanUp <- function() {
  
  faili <- list.files(
    path = "data",
    pattern = "\\.(csv|RData)$",
    full.names = TRUE,
    recursive = FALSE
  )
  
  #Izdzēš datu failus
  unlink(faili)
  
  return(cat(paste0("No ID01c datu mapes izdzēsts: ", faili, "\n")))
}
