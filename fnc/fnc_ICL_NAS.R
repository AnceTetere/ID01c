ICL_NAS <- function(year, Q) {

options(digits = 22)
#1. Ielādē non-adjusted IXs no ICL_yyyy_aprekini.
library(XLConnect)
wb <- loadWorkbook(paste0("../1_sagatavosana/ICL_", year, "_aprekini.xlsx"),
                   create = FALSE,
                   password = NULL)
ws <- readWorksheet(wb, sheet = "all_transposed")
rm(wb)
detach("package:XLConnect", unload = TRUE)

ws <- ws[ , 1:5]
colnames(ws) <- ws[1, ]
colnames(ws)[4] <- "indicator"
colnames(ws)[5] <- "ICL_value_NAS"
ws <- ws[-1, ]
rownames(ws) <- NULL #7980
#ailes <- colnames(ws)

#2 saglabā datus
assign("NAS_data", ws)
rm(ws)

return(NAS_data)
}
