path <- file.path(base_path, paste0(year, "Q", Q))

#1 Ielādē šablonu
#template_path <- file.path(path, "izstrade", "intermediate_tables", "starting_templates")
#load(file.path(template_path, paste0("template_ID01c_2000_", year, "Q", Q, ".RData")))

#s <- get(paste0("template_ID01c_2000_", year, "Q", Q))
#rm(list = paste0("template_ID01c_2000_", year, "Q", Q))

#2 Sadali NAS un AS apakštabulās
X$S <- factor(X$S)

X_split <- split(X, X$S)
list2env(X_split, envir = .GlobalEnv)
rm(X, X_split)

#3 Saglabā apakštabulas
intermediate_path <- file.path(path, "izstrade", "intermediate_tables")
#save(NAS, file = file.path(intermediate_path, "NAS.RData"))
#rm(NAS)

#save(AS, file = file.path(intermediate_path, "AS.RData"))
#rm(AS)
