IC_NS <- function(i) {

#1 Ielādē non-adjusted IC_yyyy_aprekini.xlsx.
  
if (!file.exists(paste0("../IC/ID_ESTAT/", year, "/IC", year, "_Q", Q, "/workflow/1_Excel/1_sagatavosana/IC_", year, "_aprekini.xlsm"))) {
  stop("Jo funkcija IC_dati neatrada .RDATA failus mapē 'data', \
        PROGRAMMA BLOĶĒJAS.")}
  
wb <- loadWorkbook(paste0("../IC/ID_ESTAT/", year, "/IC", year, "_Q", Q, "/workflow/1_Excel/1_sagatavosana/IC_", year, "_aprekini.xlsm"),
                   create = FALSE,
                   password = NULL)
ws <- readWorksheet(wb, sheet = "all_transpose")
ws <- ws[ , 1:5]
colnames(ws) <- ws[1, ]
colnames(ws)[4] <- "indicator"
rm(wb)

colnames(ws)[5] <- "IC_value_NS"
ws <- ws[-1, ]
rownames(ws) <- NULL

#2 Nosaukuma maiņa
assign("NS_data", ws)
rm(ws)

return(NS_data)
}
