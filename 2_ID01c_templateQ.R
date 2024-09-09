#-------- IZVEIDO CETURKŠŅA ŠABLONU-------
#template_path <- file.path(base_path, paste0(year, "Q", Q), "izstrade", "intermediate_tables", "starting_templates")

#1 Ceturkšņa šablonu veido no iepriekšējajā solī izveidotā lielā šablona "Temp".
#if(Q == 1) {
#  fileName <- paste0("template_ID01c_2000_", year-1, "Q4")
#} else {
#  fileName <- paste0("template_ID01c_2000_", year, "Q", Q-1)
#}

#load(file.path(template_path, paste0("1_", fileName, ".RData")))
#y <- get(fileName)
#rm(list = fileName, fileName)

#2 Atlasa pēdējo ceturksni
if(Q == 1) {
  t <- Temp[Temp$T == paste0(year-1, "Q4"), ] # "t" - quaterly template
} else {
  t <- Temp[Temp$T == paste0(year, "Q", Q-1), ] 
} # 114

#3 Sakārto un iztīra
rownames(t) <- NULL
t$T <- paste0(year, "Q", Q)
t$I2020 <- "" 
t$I2020_X <- ""
t$PCH_SAME <- ""
t$PCH_SAME_X <- ""

#4 Izveido rindu aili jaunajam ceturksnim un, attiecīgi, vektoru tam.
t$rindas <- paste0(t$T, t$I, t$S, t$N)
row_order2 <- t$rindas

#5 Uzreiz izveido gala faila rindu vektoru
#row_order1 <- readRDS(file.path(template_path, "1_rindas.RDS"))
row_order <- append(row_order1, row_order2) # 11 172
rm(row_order1)

#6 Saglabā ceturkšņa šablonu un rindas
#fileName <- paste0("templateQ_ID01c_", year, "Q", Q)
#assign(fileName, t)
#rm(t)

#save(list = fileName, file = file.path(template_path, paste0("2_", fileName, ".RData")))
#rm(list = fileName, fileName)

#saveRDS(row_order2, file = file.path(template_path, "2_rindas.RDS"))
#rm(row_order2)

#saveRDS(row_order, file = file.path(template_path, "Rindas_kopa.RDS"))
#rm(row_order)
