library(tidyverse)
source("C:\\Users\\autumn\\OneDrive - 연세대학교 (Yonsei University)\\바탕 화면\\OR확정 term project/term_functions.R")
setwd("C:/A")
electricity_data <- tibble()
electricity_data <- read_value("project_data.xlsx")

electricity_data %>% head()
electricity_data <- electricity_data %>% mutate(
  HOUSE = str_replace_all(HOUSE, "House ", ""),
  HOUSE = as.integer(HOUSE)
) %>% mutate(
  variables = ifelse(str_detect(variables, "Power"),
                     "Solar Generation",
                     variables)
) # Solar Power Generation 1 Hour 제거 

electricity_data %>% count(variables) # 변수 상태 확인 

electricity_data %>% mutate(
  HOUSE = as_factor(HOUSE)
)

demand <- electricity_data %>% filter(variables == "Demand")
solar_energy <- electricity_data %>% filter(str_detect(variables, "Solar"))
price <- electricity_data %>% filter(variables == "Price")
demand %>% head()

library(xlsx)
write.xlsx(demand, "demand.xlsx")
write.xlsx(solar_energy, "solar.xlsx")
write.xlsx(price, "price.xlsx")



library(tidyverse)
i = 6
h = 10 # house_number

demand %>% filter(HOUSE == electricity_data$HOUSE[h]) %>% 
  pivot_longer(3:length(price)) %>%
  mutate( 
    name = as.integer(name) %>%
  ggplot(aes(x = name, y = value)) +
  geom_line(colour = "red") + 
  labs(x = "시간", y = "수요")

i = 4416/4
  
solar_energy %>% filter(HOUSE == electricity_data$HOUSE[h]) %>% 
  pivot_longer(3:length(price)) %>%
  mutate( 
    name = as.integer(name)
  ) %>% filter(row_number() <= i) %>%
  ggplot(aes(x = name, y = value)) +
  geom_line(colour = "orange") + 
  labs(x = "시간", y = "태양광")

price %>% filter(HOUSE == 27) %>% 
  pivot_longer(3:length(price)) %>%
  mutate( 
    name = as.integer(name)
    ) %>%
  ggplot(aes(x = name, y = value)) +
  geom_line(colour = "red") + 
  labs(x = "시간", y = "가격")



solar_energy %>% head()
solar_energy %>% filter(HOUSE == 27) %>%
  pivot_longer(cols = 3:length(solar_energy)) %>%
  filter(row_number() <= 480) %>% mutate(
    name = as.integer(name)
  ) %>%
  ggplot(aes(x = name, y = value, group = 1)) +
  geom_line()
