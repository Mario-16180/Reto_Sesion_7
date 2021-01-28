library(rvest)
library(hablar)
library(dplyr)
url <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(url)
tables <- html_nodes(file, "table") 
table1 <- html_table(tables[1], fill = TRUE)
table1 <- as.data.frame(table1, row.names = NULL)

table1$Sueldo <- gsub("MXN","",table1$Sueldo)
table1$Sueldo <- gsub("/mes","",table1$Sueldo)
table1$Sueldo <- gsub(",","",table1$Sueldo)
table1$Cargo <- gsub("Sueldos para Data Scientist en ","",table1$Cargo)
table1$Sueldo <- gsub("\\$", "", table1$Sueldo)
table1$Cargo <- gsub(" \\- \\w.*","",table1$Cargo)

table1 <- table1 %>% 
  convert(int(Sueldo))

summary(table1)

filter(table1, max(table1$Sueldo) == table1$Sueldo)
filter(table1, min(table1$Sueldo) == table1$Sueldo)

# Cambio plox