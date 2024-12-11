#Izstrādā šablonu
r1 <- fTemplate()

#Sadala šablonu
r2 <- templateSplit_NA_SS(r1$finalTemplate)

#Ievieto datus šablonā un aprēķina procentuālās izmaiņas
#Noformē, izprintē, un saglabā mapē 'output'.
printOut(DII(r2$NS, r2$SS, r1$ailes_order, r1$row_order))

#Izdzēs izmantotos datus no mapes data.
message(cleanUp())

rm(list = ls())
