ICL_dati <- function(year, Q, i) {
  
  #1. Ielādē indeksus.
  nD <- paste0(tolower(i), "ICL_00Q1_", substr(year, 3,4), "Q", Q)
  if (file.exists(paste0(ICL_path, nD, ".RData"))) {
    load(paste0(ICL_path, nD, ".RData"))
  } else {
    x <- ICL_NAS(year, Q, i)
    assign(nD, x)
  }
  df <- get(nD)
  rm(nD)  
  
  colnames(df)[5] <- paste0("ICL_value_", i)
  df$Nace[df$Nace == "B_S LASP"] <- "B-S"  
  df$Nace[df$Nace == "B_S_LASP"] <- "B-S"
  rownames(df) <- NULL #7980
    
    return(df)
}
