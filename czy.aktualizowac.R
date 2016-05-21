




czy.aktualizowac <- function(dane, baza){
  
  
  
  czy.akt.dane     <- TRUE
  czy.akt.rozklady <- TRUE
  
  id.nowe.dane     <- id.nowe.rozklady <- 1:nrow(dane)

  
  
  
  db <- dbConnect(SQLite(), dbname = baza)
  
  
  
  # jesli aktualizowac tabele dane, to ktore wiersze?
  
  if ("dane" %in% dbListTables(db)){
    
    id.stare <- dbGetQuery(db, "select id from dane")$id
    id.nowe.dane  <- subset(dane$id, !dane$id %in% id.stare)
    id.nowe.dane  <- which(dane$id == id.nowe.dane)
    
    czy.akt.dane <- ifelse(length(id.nowe.dane) > 0, TRUE, FALSE)
  } 
  
  
  
  
  
  # jesli aktualizowac tabele rozklady, to ktore wiersze?
  
  if ("rozklady" %in% dbListTables(db)){
    
    id.stare <- dbGetQuery(db, "select id from rozklady")$id
    id.nowe.rozklady  <- subset(dane$id, !dane$id %in% id.stare)
    id.nowe.rozklady  <-  which(dane$id == id.nowe.rozklady)
    
    czy.akt.rozklady <- ifelse(length(id.nowe.rozklady) > 0, TRUE, FALSE)
  }
  
  
  suppressWarnings(dbDisconnect(db))
  
  
  
  
  list(
         co.akt  = list(dane=id.nowe.dane, rozklady=id.nowe.rozklady),
         czy.akt = list(dane=czy.akt.dane, rozklady=czy.akt.rozklady)
       )
  
  
  
  
}


