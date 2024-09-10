#----------------Procentu aprēķini

c <- c("NAS", "AS")

for (i in 1:length(c)) {
  #1. Ielādē gatavo indeksu tabulu
  load(file.path(intermediate_path, paste0("gatavs_", c[i], "00Q1_", substr(year, 3, 4), "Q", Q, ".RData")))
  assign("g", get(paste0("gatavs_", c[i]))) # g for gatavs
  rm(list = paste0("gatavs_", c[i]))
  
  #pārbaudi tabulu
  if (sum(g$S == c[i]) == nrow(g)) {
    #2. Izstrādā procentu aprēķinus
    
    burti <-
      g$NACE[g$TIME == paste0(year, "Q", Q) & g$I == "LC_TOTAL"]
    gadi <- c(year:2001)
    
    # sadalām pa ii
    g_split <- split(g, g$I)
    names(g_split) <- paste0("g_", names(g_split))
    g_ind <-
      names(g_split) # g_ind vor gatavie indikatori (kaut kā tā)
    list2env(g_split, envir = .GlobalEnv)
    rm(g, g_split)
    
    for (gads in gadi) {
      for (g in g_ind) {
        x <- get(g)
        for (burts in burti) {
          if (gads == year) {
            #vispirms sarēķini tekošo gadu
            for (q in Q:1) {
              x$PCH_ASME[x$TIME == paste0(year, "Q", q) & x$NACE == burts] <-
                x$I2020[x$TIME == paste0(year, "Q", q) &
                          x$NACE == burts] / x$I2020[x$TIME == paste0(year - 1, "Q", q) &
                                                       x$NACE == burts] * 100 - 100
            }
          } else {
            #tad pārējo
            for (q in 4:1) {
              x$PCH_ASME[x$TIME == paste0(gads, "Q", q) & x$NACE == burts] <-
                x$I2020[x$TIME == paste0(gads, "Q", q) &
                          x$NACE == burts] / x$I2020[x$TIME == paste0(gads - 1, "Q", q) &
                                                       x$NACE == burts] * 100 - 100
            }
          }
        }
        assign(g, x)
        rm(x)
      }
    }
    rm(burts, g, gadi, gads, q)
    
    #3. Savieno un saglabā
    fileName <- paste0("gataviProc_", c[i])
    s <- rbind(g_LC_OTH, g_LC_TOTAL, g_LC_WAG_TOT)
    assign(fileName, s)
    rm(s, g_LC_OTH, g_LC_TOTAL, g_LC_WAG_TOT)
    
    save(list = fileName,
         file = file.path(intermediate_path, paste0(fileName, "00Q1_", substr(year, 3, 4), "Q", Q, ".RData")))
    rm(burti, g_ind, fileName)
  } else {
    print("Datu koriģēšanas atzīmes nesakrīt.")
  }
}
rm(c, i)

#4. Saliec kopā NAS un AS galējajam ID01c. Un izprintē kā ID01c_unformatted

f <- rbind(gataviProc_NAS, gataviProc_AS)
rm(gataviProc_NAS, gataviProc_AS)

starting_path <- file.path(path, "izstrade", "intermediate_tables", "starting_templates")
rindas_order <- readRDS(file.path(starting_path, "Rindas_kopa.RDS"))

if (nrow(f) == length(rindas_order)) {
  f <- f[order(match(f$rindas, rindas_order)),]
  rownames(f) <- NULL
  assign("finalID01c_unformatted", f)
  
  save(finalID01c_unformatted, file = file.path(intermediate_path, "finalID01c_unformatted.RData"))
  rm(f, finalID01c_unformatted, rindas_order)
} else {
  stop("Rindu skaits nesakrīt.")
  rm(f)
}
