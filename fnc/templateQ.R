templateQ <- function(Temp, row_order1) {

  if(Q == 1) {
    t <- Temp[Temp$TIME == paste0(year-1, "Q4"), ] 
  } else {
    t <- Temp[Temp$TIME == paste0(year, "Q", Q-1), ] 
  }
  
  #PĀRBAUDE
  if (nrow(t) != 114) {stop("templateQ: Ceturkšņa šablona rindu skaits neatbilst.")}
  
  #2 Sakārto un iztīra
  rownames(t) <- NULL
  t$TIME <- paste0(year, "Q", Q)
  t$I2020 <- "" 
  t$I2020_X <- ""
  t$PCH_SAME <- ""
  t$PCH_SAME_X <- ""
  
  #3 Izveido rindu aili jaunajam ceturksnim un, attiecīgi, vektoru tam.
  t$rindas <- paste0(t$TIME, t$INDICATOR, t$SESON, t$N)
  row_order2 <- t$rindas
  
  #4 Uzreiz izveido gala faila rindu vektoru.
  row_order <- append(row_order1, row_order2)
  rm(Temp, row_order1)
  
  return(list(t = t, row_order2 = row_order2, row_order = row_order))
  }
