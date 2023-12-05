library(tidyverse)
library(readxl)
setwd("C:/A")
read_value <- function(fname){
  
  mydata <- tibble()
  
  for(i in seq(length(excel_sheets(fname)))){
      temp <- read_excel(fname, 
                         sheet = excel_sheets(fname)[i])
      
      temp <- temp %>% mutate(
        time_H = row_number()
      ) %>% relocate(
        time_H
      ) %>%
        pivot_longer(cols = -time_H, names_to = 'variables') %>% 
        pivot_wider(names_from = time_H, values_from = value) %>% mutate(
        ) %>% mutate(
          HOUSE = excel_sheets(fname)[i]
        ) %>% relocate(
          HOUSE
        )
      mydata <- bind_rows(mydata, temp)
  }
  return(mydata)
}
# data <- read_value("project_data.xlsx")
# for(i in seq(14)){
#   print(typeof(excel_sheets("project_data.xlsx")[i]))
# }
# length(excel_sheets("project_data.xlsx"))
# 
# get_name <- function(fname){
#   for(i in seq(14)){
#     print(typeof(excel_sheets(fname)[i]))
#   }
#   }# 
# get_name("project_data.xlsx")
# temp <- tibble()
# 
# 
# temp <- read_excel("project_data.xlsx", sheet = 1)
# 
# temp %>% mutate(
#   time = str_c(row_number(), "H")
# ) %>% relocate(
#   time
# ) %>%
#   pivot_longer(cols = -time, names_to = 'Time') %>%
#   pivot_wider(names_from = time, values_from = value) %>% mutate(
# ) %>% mutate(
#   HOUSE = 1
# ) %>% relocate(
#   HOUSE
# )
# df1
# 
# 
# temp <- read_value("project_data.xlsx")
# 
# getwd()
