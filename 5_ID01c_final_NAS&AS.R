#----------------Izstrādā NAS un AS
#path <- file.path(base_path, paste0(year, "Q", Q))
c <- c("NAS", "AS")

for (i in c) {
#1 Ielādē šablonu
#template_path <- file.path(path, "izstrade", "intermediate_tables", paste0(c[i], ".RData"))
#load(template_path) #5529
#assign("t", get(c[i])) 
t <- get(c[i])
rm(list = c[i])
t$forMerge <- paste0(t$T, "_", t$N)

#2 Ielādē ceturkšņa indeksus
data_path <- file.path(paste0("../sagatavošana/intermediate_tables"))
if(c[i] == "NAS") {
  nasICL <- NAS(year, Q)
  #load(paste0("..gatavs_nasLCI_00Q1_", substr(year, 3, 4), "Q", Q, ".RData"))
  } else {
    load(paste0("..gatavs_saLCI_00Q1_", substr(year, 3, 4), "Q", Q, ".RData"))}

d <- nasICL #8232 ---- "d" for data
rm(nasICL)


#3 No LCI datu tabulas izņemt N agregātus B-N un O-S
d <- d[!d$ACTIVITY %in% c("BTN", "OTS"), ] #7220
d$ACTIVITY[d$ACTIVITY == "BTS"] <- "B-S"

# Savienošanas aile
d$forMerge <- paste0(substr(d$T_PERIOD, 1, 4), 
                          substr(d$T_PERIOD, 6, 7), "_", d$ACTIVITY)

# No nasICL izņem indikatoru “Total_except_bonuses” un izdala ailes
d <- d[d$I != "LCI_TXB", ] #5358

testV <- switch(
  c[i],
  "NAS" = "N",
  "AS" = "Y"
)

if(sum(d$A_S == testV) == nrow(d) & sum(t$forMerge %in% d$forMerge) == nrow(d)) {
  d <- d[ , c("I", "OBS_VALUE", "forMerge")]
} else {
  stop("Visi dati nav sezonāli koriģēti.")
}
rm(testV)

#5 Sadala šablonu pa I
t$I <- factor(t$I)

T_split <- split(t, t$I)
names(T_split) <- paste0(c[i], "_", names(T_split))
temp_T <- names(T_split)
list2env(T_split, envir = .GlobalEnv)
rm(T_split, t)

#6 Sadala LCI datus
d$I <- factor(d$I)

D_split <- split(d, d$I)
names(D_split) <- paste0(tolower(c[i]), "_", names(D_split))
list2env(D_split, envir = .GlobalEnv)
rm(D_split, d)

#7 Datu savienošanas funkcija
for(j in 1:length(temp_T)) {
  x1 <- temp_T[j]
  
  x2 <- ifelse(
    x1 == paste0(c[i], "_LC_OTH"),
    paste0(tolower(c[i]), "_LCI_O"),
    ifelse(
      x1 == paste0(c[i], "_LC_TOTAL"),
      paste0(tolower(c[i]), "_LCI_T"),
      ifelse(
        x1 == paste0(c[i], "_LC_WAG_TOT"),
        paste0(tolower(c[i]), "_LCI_WAG"),
        print("Nepareizs tabulas nosaukums vektorā.")
      )
    )
  )
  
  
  mergedDF <- merge(get(x1), get(x2)[ , c("OBS_VALUE", "forMerge")], by.x = "forMerge", by.y = "forMerge")
  mergedDF$I2020 <- mergedDF$OBS_VALUE
  mergedDF$OBS_VALUE <- NULL
  mergedDF$forMerge <- NULL
  assign(paste0("gatavs_", j), mergedDF)
  rm(list = c(x1, x2), mergedDF, x1, x2)
}
rm(j, temp_T)

#8 Sašuj gatavās tabulas kopā un noglabā
y <- rbind(gatavs_1, gatavs_2, gatavs_3)
rm(gatavs_1, gatavs_2, gatavs_3)

assign(paste0("gatavs_", c[i]), y)
#intermediate_path <- file.path(path, "izstrade", "intermediate_tables")
#save(list = paste0("gatavs_", c[i]), file = file.path(intermediate_path, paste0("gatavs_", c[i], "00Q1_", substr(year, 3, 4), "Q", Q, ".RData")))

#rm(list = paste0("gatavs_", c[i]), y)
}

rm(c, i)
