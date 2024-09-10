#install.packages("here")
library(here)

Sys.setenv(JAVA_OPTS = "-Xmx8g")
options(digits = 22)

year <- 2024
Q <- 2
base_path <- here("../ID01c/")

#1 Šablonam izmanto iepriekšējā ceturkšņa gala failu.
if(Q == 1) {
  fileName <- paste0("template_ID01c_2000_", year-1, "Q4")
} else {
  fileName <- paste0("template_ID01c_2000_", year, "Q", Q-1)
}

ID01c_path <- here(base_path, "DB_fails", "ID01c.csv")
ID01c <- read.csv2(ID01c_path, sep = ";") # 11058
assign("Temp", ID01c) # "Temp" for the grand template
rm(ID01c, ID01c_path)

#2 Noformē
Temp$PCH_SAME_X[is.na(Temp$PCH_SAME_X)] <- ""
Temp$I2020_X[is.na(Temp$I2020_X)] <- ""
rownames(Temp) <- NULL # 11058

#3 Izveido rindu aili un rindu vektoru, pēc kura šo tabulu varēs savākt kopā
Temp$rindas <- paste0(Temp$TIME, Temp$INDICATOR, Temp$SESON, Temp$NACE)
row_order1 <- Temp$rindas

#4 Izveido aiļu vektoru, pēc kura pēcāk šo tabulu savākt kopā
ailes_order <- colnames(Temp)
