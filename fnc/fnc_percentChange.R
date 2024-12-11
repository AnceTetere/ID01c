percentChange <- function(gD, i) {

#pārbaudi tabulu
if (sum(gD$SESON == i) == nrow(gD)) {
  
  burti <- gD$N[gD$TIME == paste0(year, "Q", Q) & gD$INDICATOR == "TOTAL"]
  gadi <- c(year:2001)
  
  #1 Sadala pa indicator
  g_split <- split(gD, gD$INDICATOR)
  names(g_split) <- paste0("gD_", names(g_split))
  g_ind <-
    names(g_split) 
  list2env(g_split, envir = environment())
  rm(gD, g_split)
  
  for (gads in gadi) {
    for (g in g_ind) {
      x <- get(g)
      for (burts in burti) {
        if (gads == year) {
          for (q in Q:1) {
            x$PCH_SAME[x$TIME == paste0(year, "Q", q) & x$N == burts] <-
              x$I2020[x$TIME == paste0(year, "Q", q) &
                        x$N == burts] / x$I2020[x$TIME == paste0(year - 1, "Q", q) &
                                                     x$N == burts] * 100 - 100
          }
        } else {
          #tad pārējo
          for (q in 4:1) {
            x$PCH_SAME[x$TIME == paste0(gads, "Q", q) & x$N == burts] <-
              x$I2020[x$TIME == paste0(gads, "Q", q) &
                        x$N == burts] / x$I2020[x$TIME == paste0(gads - 1, "Q", q) &
                                                     x$N == burts] * 100 - 100
          }
        }
      }
      assign(g, x, , envir = environment())
      rm(x)
    }
  }
  rm(burts, g, gadi, gads, q)
  
  #3 Savieno un atdod atpakaļ
  #fileName <- paste0("gataviProc_", c[i])
  s <- rbind(gD_OTH, gD_TOTAL, gD_WAG_TOT)
  
  #save(list = fileName,
       #file = file.path(intermediate_path, paste0(fileName, "00Q1_", substr(year, 3, 4), "Q", Q, ".RData")))
  rm(burti, g_ind, gD_OTH, gD_TOTAL, gD_WAG_TOT)
} else {
  print("Datu koriģēšanas atzīmes nesakrīt.")
}

return(s)
}
