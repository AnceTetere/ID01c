install.packages("here")
library(here)

Sys.setenv(JAVA_OPTS = "-XmTemp8g")
options(digits = 22)

year <- 2024
Q <- 2
base_path <- here("..ID01c/")

#1 Šablonam izmanto iepriekšējā ceturkšņa DB failu.
if(Q == 1) {
  fileName <- paste0("template_ID01c_2000_", year-1, "Q4")
} else {
  fileName <- paste0("template_ID01c_2000_", year, "Q", Q-1)
}

ID01c_path <- here(base_path, "DB_fails", "ID01c.csv")
ID01c <- read.csv2(ID01c_path, sep = ";") # 11058
assign("Temp", ID01c) # "Temp" for the grand template
rm(ID01c)

#2 Noformē
Temp$PCH_SAME_X[is.na(Temp$PCH_SAME_X)] <- ""
Temp$I2020_X[is.na(Temp$I2020_X)] <- ""
rownames(Temp) <- NULL # 11058

#3 Izveido rindu aili un rindu vektoru, pēc kura šo tabulu varēs savākt kopā
Temp$rindas <- paste0(Temp$T, Temp$I, Temp$S, Temp$N)
row_order1 <- Temp$rindas

#4 Izveido aiļu vektoru, pēc kuras pēcāk šo tabulu savākt kopā
ailes_order <- colnames(Temp)

#5 Saglabā
#save_dir <- here(base_path, paste0(year, "Q", Q), "izstrade", "intermediate_tables", "starting_templates")
#save_path <- file.path(save_dir, paste0("1_", fileName, ".RData"))
#assign(fileName, Temp) 
#rm(Temp)

#save(list = fileName, file = save_path)
#rm(list = fileName)

#row_order_path <- file.path(save_dir, "1_rindas.RDS")
#saveRDS(row_order1, file = row_order_path)
#rm(row_order1)

ailes_order_path <- file.path(save_dir, "1_ailes.RDS")
saveRDS(ailes_order, file = ailes_order_path)
rm(ailes_order, fileName)
