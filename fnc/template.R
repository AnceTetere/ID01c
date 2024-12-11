template <- function() {

  ID01c <- read.csv2("data/ID01c.csv")
  assign("Temp", ID01c, envir = environment())
  rm(ID01c)
  
  #2 Noformē
  Temp$PCH_SAME_X[is.na(Temp$PCH_SAME_X)] <- ""
  Temp$I2020_X[is.na(Temp$I2020_X)] <- ""
  rownames(Temp) <- NULL
  
  #3 Izveido rindu aili un rindu vektoru, pēc kura šo tabulu varēs savākt kopā
  Temp$rindas <- paste0(Temp$TIME, Temp$INDICATOR, Temp$SESON, Temp$N)
  row_order1 <- Temp$rindas
  
  #4 Izveido aiļu vektoru, pēc kura pēcāk šo tabulu savākt kopā
  ailes_order <- colnames(Temp)
  
  return(list(Temp = Temp, row_order1 = row_order1, ailes_order = ailes_order))
}
