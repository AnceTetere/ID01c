IDD <- function(NS, SS, ailes_order, row_order){
  #----------------Izstrādā NS un SS
  c <- c("NS", "SS")
  IDD <- data.frame()
  
  for (i in c) {
    #1 Ielādē šablonu
    t <- get(i)
    rm(list = i)
    
    #2 Ielādē IC datus
    n <- IC_dati(i)
    
    #PĀRBAUDE PAR TRANSPONĒŠANU
    a <- paste0("IC_value_", i)
    if (sum(n[ , a][n$Gads == year] < 100, na.rm = TRUE) > 0) {
      stop("Failos 'aprēķini_yyyy.xlsx' vai 'IC_ggggCq_SS.xls' pirms Macros palaišanas nav notikusi transponēšana!")
    }
    
    #3 Noformē
    #  pārmaini indikatoru
    n$indicator[n$indicator == "Total"] <- "TOTAL"
    n$indicator[n$indicator == "Wag"] <- "WAG_TOT"
    n$indicator[n$indicator == "Oth"] <- "OTH"
    
    #  izveido time_period
    n$time_period <- paste0(n$Gads, "Q", n$Q)
    n$Gads <- NULL
    n$Q <- NULL
    n <- n[ , c("time_period", "N", "indicator", a)]
    
    #  izveido savienošanas agregātu
    n$forMerge <- paste0(n$time_period, n$indicator, "_", n$N)
    t$forMerge <- paste0(t$TIME, t$INDICATOR, "_", t$N)
    t_order <- t$forMerge
    
    if (any(c(length(t$forMerge[!(t$forMerge %in% n$forMerge)]), length(n$forMerge[!(t$forMerge %in% n$forMerge)])) != 0)) {
      stop("merge_NS_SS: Savienojamo vērtību nesakritība.")
    }
    
    #4 Savieno
    mergedDF <- merge(t, n[ , c(a, "forMerge")], by.x = "forMerge", by.y = "forMerge")
    # pārcel datus
    mergedDF$I2020 <- mergedDF[ , a]
    # sakārto apakštabulu
    mergedDF <- mergedDF[order(match(mergedDF$forMerge, t_order)), ]
    mergedDF <- mergedDF[ , ailes_order]
    rownames(mergedDF) <- NULL
    
    #5 Pēdējās pārbaudes un noglabā
    if (sum(mergedDF$SESON == i) == nrow(mergedDF)) {
      gD <- mergedDF 
      rm(mergedDF)
    } else {
      stop("IDD: SESON ailē norāde neatbilst.")
    }
    
    #6 Sarēķini procentus
    gP <- percentChange(gD, i) 
    IDD <- rbind(IDD, gP)
    rm(gP, gD, n, t, t_order)
  }
  
  if (nrow(IDD) == length(row_order)) {
    IDD <- IDD[order(match(IDD$rindas, row_order)),]
    rownames(IDD) <- NULL
  } else {
    stop("IDD: Gala nenoformētajā tabulā rindas neatbilst! \n")
  }
return(IDD)  
}
