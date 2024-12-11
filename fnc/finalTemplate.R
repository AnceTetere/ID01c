fTemplate <- function() {
  #1 Iepriekšējā ceturkšņa nodevumu lieto kā lielo sākuma šablonu.
  #  Funkcija template() atgriež šo šablonu tīru no iepriekšējā nodevuma datiem kopā ar rindu kārtību un aiļu secību.
  r1 <- template()
  
  #2 Tekošo ceturksni atvasina no lielā sākuma šablona, izmantojot funkciju templateQ()
  r2 <- templateQ(r1$Temp, r1$row_order1)
  
  # Gala šablonu veido savienojot iepriekšējā ceturkšņa DB failu ar tekošo ceturksni un izformē.
  X <- rbind(r1$Temp, r2$t)
  if (nrow(X) != nrow(r1$Temp) + 114) {stop("fTemplate: Gala šablonam rindu skaits neatbilst.")}
  
  X$I2020 <- ""
  X$I2020_X <- ""
  X$PCH_SAME <- ""
  
  return(list(finalTemplate = X,
              ailes_order = r1$ailes_order,
              row_order = r2$row_order))
}
