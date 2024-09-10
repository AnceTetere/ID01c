# ESTAT ICL failā ievieto nas datus
NAS <- function(year, Q) {
  
#1 Ielādē šablonu
#r <- ICL_templates (year, Q)
#temp <- r$temp
#temp_order <- temp_order
#rm(r)

#2 Izdalām NAS rindas indeksiem
t_nas <- temp[temp$SEASONAL_ADJUST == "N" & temp$UNIT_MEASURE == "IX", ]

#3 Paņem NAS datus
NAS_data <- ICL_NAS(year, Q)
n <- NAS_data
rm(NAS_data)

#PĀRBAUDE VAI JAU ATKAL NEESI AIZMIRSUSI TRANSPONĒT
if (sum(n$ICL_value_NAS[n$Gads == year] < 100, na.rm = TRUE) > 0) {
  stop("Dati aprēķini_yyyy.xlsx: Pirms Macros esi aizmirsusu transponēt!")
}

#4 izveido aili savienošanai
# pārmaini indikatoru
for(i in 1:length(n$ii)) {
  n$ii[i] <- switch(n$ii[i],
                           "Total" = "ICL_T",
                           "Wages" = "ICL_WAG",
                           "Other" = "ICL_O",
                           "Total except bonuses" = "ICL_TXB"
  )
}

#pārmaini N Lasp
n$N[n$N == "B_N_LASP"] <- "BTN"
n$N[n$N == "B_S_LASP"] <- "BTS"
n$N[n$N == "O_S_LASP"] <- "OTS"

#izveido time_period
n$time_period <- paste0(n$Gads, "-Q", n$Q)

n$forMerge <- paste0(n$time_period, n$ii, "_", n$N)
t_nas$forMerge <- paste0(t_nas$TIME_PERIOD, t_nas$I, "_", t_nas$A)
t_nas_order <- t_nas$forMerge
ailes_t_nas <- colnames(t_nas)

t_nas$forMerge[!(t_nas$forMerge %in% n$forMerge)]
n$forMerge[!(t_nas$forMerge %in% n$forMerge)]

#5 Savieno
mergedDF <- merge(t_nas, n[ , c("ICL_value_NAS", "forMerge")], by.x = "forMerge", by.y = "forMerge")

#pārcel datus
mergedDF$OBS_VALUE <- mergedDF$ICL_value_NAS

#sakārto apakštabulu
mergedDF <- mergedDF[ , ailes_t_nas]
mergedDF <- mergedDF[order(match(mergedDF$forMerge, t_nas_order)), ]
rownames(mergedDF) <- NULL
mergedDF$forMerge <- NULL
mergedDF$CONF_STATUS <- "F"
rm(n, t_nas, i, ailes_t_nas, t_nas_order)

#6 Pēdējās pārbaudes un noglabā
sum(mergedDF$SEASONAL_ADJUST == "N") == nrow(mergedDF)
nasICL <- mergedDF
rm(mergedDF, temp)

return(nasICL)
}
