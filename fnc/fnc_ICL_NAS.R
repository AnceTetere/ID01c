ICL_NSA <- function(year, Q, i) {

#1 Ielādē non-adjusted indeksus no ICL_yyyy_aprekini.xlsx.
wb <- loadWorkbook(paste0("../1_sagatavosana/ICL_", year, "_aprekini.xlsx"),
                   create = FALSE,
                  password = NULL)
ws <- readWorksheet(wb, sheet = "all_transpose") 
ws <- ws[ , 1:5]
colnames(ws) <- ws[1, ]
colnames(ws)[4] <- "indicator"
rm(wb)
detach("package:XLConnect", unload = TRUE)

colnames(ws)[5] <- "ICL_value_NAS"
ws <- ws[-1, ]
rownames(ws) <- NULL

#2 saglabā datus
assign("NAS_data", ws)
rm(ws)

return(NAS_data)
}
