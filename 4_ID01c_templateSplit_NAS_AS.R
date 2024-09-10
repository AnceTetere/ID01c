#1 Sadali NAS un AS apakštabulās
X$S <- factor(X$S)

X_split <- split(X, X$S)
list2env(X_split, envir = .GlobalEnv)
rm(X, X_split)
