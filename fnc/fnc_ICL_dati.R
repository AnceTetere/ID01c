IC_dati <- function(i) {
  
  #1 Ielādē indeksus.
  nD <- paste0(tolower(i), "IC_00Q1_", substr(year, 3,4), "Q", Q)
  
  #Ja programmatūra neatradīs .RDATA failus mapē 'data', 
  #funkcija IC_NS(i) centīsies to izstrādāt no ESTAT sagataves datnēm.
  #Tā bloķēsies ja fails netiks atrasts.
  
  if (file.exists(paste0("data/", nD, ".RData"))) {
    load(paste0("data/", nD, ".RData"))
  } else if(i == "NS") {
      assign(nD, IC_NS(i), envir = environment())
    } else {
      stop("fnc_IC_dati: Izstrādā funkciju IC_SS(year, Q, i) līdzīgu IC_NS(year, Q, i), kas paņem SS datus no Excel dokumenta.")}
  
  df <- get(nD)
  rm(list = nD, nD)  
  
  colnames(df)[5] <- paste0("IC_value_", i)
  df$N[df$N == "B_S LASP"] <- "B-S" 
  df$N[df$N == "B_S_LASP"] <- "B-S"
  rownames(df) <- NULL
    
  return(df)
}
