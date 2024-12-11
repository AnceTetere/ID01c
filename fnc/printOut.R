printOut <- function(x) {
  #Noformē
  x$I2020 <- sprintf("%.1f", round(as.double(x$I2020), 1)) 
  x$PCH_SAME <- sprintf("%.1f", round(as.double(x$PCH_SAME), 1)) 
  
  x$PCH_SAME[x$PCH_SAME == "NA"] <- ""
  x$rindas <- NULL
  
  #3 Izprintē
  write.table(x, file = "output/ID01c_final.csv", sep = ";", col.names = TRUE, row.names = FALSE, qmethod = "double")
  rm(x)
  
  return(cat("ID01c gatava un noformēta atrodama output/ID01c_final.csv. \n \n"))}
