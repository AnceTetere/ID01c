#----------------Izstrādā NAS un AS
c <- c("NAS", "AS")
IID <- data.frame()

for (i in c) {
#1 Ielādē šablonu
t <- get(i)
rm(list = i)

#2 Ielādē ICL datus
n <- ICL_dati(year, Q, i)

#PĀRBAUDE VAI JAU ATKAL NEESI AIZMIRSUSI TRANSPONĒT
a <- paste0("ICL_value_", i)
if (sum(n[ , a][n$Gads == year] < 100, na.rm = TRUE) > 0) {
  stop("Failos 'aprēķini_yyyy.xlsx' vai 'ICL_ggggCq_AS.xls' pirms Macros palaišanas esi aizmirsusi transponēt datus!")
}

#3 Noformē
n$ii[n$ii == "tt"] <- "CL_T"
n$ii[n$ii == "ww"] <- "CL_WT"
n$ii[n$ii == "oo"] <- "CL_O"

#  izveido time_period
n$time_period <- paste0(n$Gads, "Q", n$Q)
n$Gads <- NULL
n$Q <- NULL
n <- n[ , c("time_period", "n", "ii", a)]

#  izveido savienošanaa agregātu
n$forMerge <- paste0(n$time_period, n$ii, "_", n$n)
t$forMerge <- paste0(t$TIME, t$INDICATOR, "_", t$N)
t_order <- t$forMerge

if (any(c(length(t$forMerge[!(t$forMerge %in% n$forMerge)]), length(n$forMerge[!(t$forMerge %in% n$forMerge)])) != 0)) {
  stop("5_ID01c_final_NAS&AS: Savienojamo vērtību nesakritība.")
}

#4 Savieno
mergedDF <- merge(t, n[ , c(a, "forMerge")], by.x = "forMerge", by.y = "forMerge")
# pārcel datus
mergedDF$I2020 <- mergedDF[ , a]
# sakārto apakštabulu
mergedDF <- mergedDF[order(match(mergedDF$forMerge, t_order)), ]
mergedDF <- mergedDF[ , ailes_order]
rownames(mergedDF) <- NULL
#rm(n, t, t_order)

#5 Pēdējās pārbaudes un noglabā
if (sum(mergedDF$S == i) == nrow(mergedDF)) {
  gD <- mergedDF #gD: kā gatavs dati
  rm(mergedDF)
} else {
  stop("5_ID01c_final_NAS&AS: S ailē norāde neatbilst.")
}

#6 Sarēķini procentus
gP <- percentChange(year, Q, gD, i) #gP: kā gatavs procenti
IID <- rbind(IID, gP)
rm(gP, gD)
}

if (nrow(IID) == length(row_order)) {
  IID <- IID[order(match(IID$rindas, row_order)),]
  rownames(IID) <- NULL
} else {
  stop("5_ID01c_final_NAS&AS: Gala nenoformētajā tabulā rindas neatbilst! \n")
}
