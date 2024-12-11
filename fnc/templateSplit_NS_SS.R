templateSplit_NS_SS <- function(X) {

  #1 Sadali NS un SS apakštabulās
  X$SESON <- factor(X$SESON)
  
  X_split <- split(X, X$SESON)
  list2env(X_split, envir = environment())
  rm(X, X_split)
  
  return(list(NS = NS, SS = SS))
}
