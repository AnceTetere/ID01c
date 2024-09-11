
#Procentu sarēķins

percentChange <- function(year, Q, gD, i) {

#pārbauda tabulu
if (sum(gD$S == i) == nrow(gD)) {
  
  burti <- gD$N[gD$T == paste0(year, "Q", Q) & gD$I == "CL_T"]
  gadi <- c(year:2001)
  
  #1 Sadala pa ii
  g_split <- split(gD, gD$I)
  names(g_split) <- paste0("gD_", names(g_split))
  g_ind <-
    names(g_split) 
  list2env(g_split, envir = .GlobalEnv)
  rm(gD, g_split)
  
  #2 Aprēķina procentus 
  for (gads in gadi) {
    for (g in g_ind) {
      x <- get(g)
      for (burts in burti) {
        if (gads == year) {
          #vispirms sarēķina tekošo gadu
          for (q in Q:1) {
            x$PCH_SAME[x$T == paste0(year, "Q", q) & x$N == burts] <-
              x$I2020[x$T == paste0(year, "Q", q) &
                        x$N == burts] / x$I2020[x$T == paste0(year - 1, "Q", q) &
                                                     x$N == burts] * 100 - 100
          }
        } else {
          #tad pārējo
          for (q in 4:1) {
            x$PCH_SAME[x$T == paste0(gads, "Q", q) & x$N == burts] <-
              x$I2020[x$T == paste0(gads, "Q", q) &
                        x$N == burts] / x$I2020[x$T == paste0(gads - 1, "Q", q) &
                                                     x$N == burts] * 100 - 100
          }
        }
      }
      assign(g, x)
      rm(x)
    }
  }
  rm(burts, g, gadi, gads, q)
  
  #3 Savieno un atdod atpakaļ
  s <- rbind(gD_CL_O, gD_CL_T, gD_CL_WT)
  rm(gD_CL_O, gD_CL_T, gD_CL_WT)
  
  rm(burti, g_ind)
} else {
  print("Datu koriģēšanas atzīmes nesakrīt.")
}

return(s)
}
