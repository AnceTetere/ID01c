#--------------- SAVIENO ŠABLONUS-----

#1 Ielādē lielo šablonu.
#if(Q == 1) {
#  fileName <- paste0("template_ID01c_2000_", year-1, "Q4")
#} else {
#  fileName <- paste0("template_ID01c_2000_", year, "Q", Q-1)
#}

#load(file.path(template_path, paste0("1_", fileName, ".RData")))
#X1 <- get(fileName)
#rm(list = fileName, fileName)

# 2. Ielādē ceturkšņa šablonu
#fileName <- paste0("templateQ_ID01c_", year, "Q", Q)
#load(file.path(template_path, paste0("2_", fileName, ".RData")))
#X2 <- get(fileName)
#rm(list = fileName, fileName)

#3 Savieno iepriekšējā ceturkšņa DB failu ar tekošo ceturksni vienā lielā šablonā un izformē.
X <- rbind(Temp, t) # 11 172
rm(Temp, t)

X$I2020 <- ""
X$I2020_X <- ""
X$PCH_SAME <- ""

# 4. Saglabā
#fileName <- paste0("template_ID01c_2000_", year, "Q", Q)
#assign(fileName, X)
#rm(X)

#save(list = fileName, file = file.path(template_path, paste0(fileName, ".RData")))
#rm(list = fileName, fileName)

#if(Q == 1) {
#  file_to_remove <- file.path(template_path, paste0("1_template_ID01c_2000_", year-1, "Q4.RData"))
#} else {
#  file_to_remove <- file.path(template_path, paste0("1_template_ID01c_2000_", year, "Q", Q-1, ".RData"))
#}

#if (file.exists(file_to_remove)) {
#  file.remove(file_to_remove)
#  cat(paste("Sākuma izstrādes šablons", file_to_remove, "ir izdzēsts.\n"))
#} else {
#  cat(paste("Sākuma izstrādes šablons", file_to_remove, "nav atrasts.\n"))
#}

#file.remove(file.path(template_path, "1_rindas.RDS"), file.path(template_path, "2_rindas.RDS"))
#rm(file_to_remove)
