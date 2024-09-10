#-------- IZVEIDO CETURKŠŅA ŠABLONU-------

#1 Atlasa pēdējo ceturksni
if(Q == 1) {
  t <- Temp[Temp$T == paste0(year-1, "Q4"), ] # "t" - quarterly template
} else {
  t <- Temp[Temp$T == paste0(year, "Q", Q-1), ] 
} # 114

#2 Sakārto un iztīra
rownames(t) <- NULL
t$T <- paste0(year, "Q", Q)
t$I2020 <- "" 
t$I2020_X <- ""
t$PCH_SAME <- ""
t$PCH_SAME_X <- ""

#3 Izveido rindu aili jaunajam ceturksnim un, attiecīgi, vektoru tam.
t$rindas <- paste0(t$T, t$I, t$S, t$N)
row_order2 <- t$rindas

#4 Uzreiz izveido gala faila rindu vektoru
row_order <- append(row_order1, row_order2) # 11 172
rm(row_order1)
