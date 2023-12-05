library(tidyverse)
setwd("C:/A")
##################################################################
length(solar_energy)
viz_solar   <- function(i) {
    solar_energy %>% select(1, 3:4418) %>%
    pivot_longer(cols = 2:i) %>% 
    mutate(
      name = as.numeric(name),
      HOUSE = as_factor(HOUSE)
    ) %>% 
    ggplot(aes(x = name, y = value, colour = HOUSE)) +
    geom_line() +
    labs(x = "시간", y = "태양열 발전량", colour = "HOUSE") +
    scale_x_continuous() +
    facet_wrap(~HOUSE)
}

viz_solar_unfacted <- function(i) {
  solar_energy %>% select(1, 3:4418) %>%
    pivot_longer(cols = 2:i) %>% 
    mutate(
      name = as.numeric(name),
      HOUSE = as_factor(HOUSE)
    ) %>% 
    ggplot(aes(x = name, y = value, colour = HOUSE)) +
    geom_line() +
    labs(x = "시간", y = "태양열 발전량", colour = "HOUSE") +
    scale_x_continuous()
}

viz_demand <- function(i) {
    demand %>% select(1, 3:4418) %>%
    pivot_longer(cols = 2:i) %>% 
    mutate(
      name = as.numeric(name), # 중요 
      HOUSE = as_factor(HOUSE)
    ) %>% 
    ggplot(aes(x = name, y = value, colour = as_factor(HOUSE))) +
    geom_line() +
    labs(x = "시간", y = "수요(kWh)", colour = "HOUSE") +
    scale_x_continuous() +
    facet_wrap(~HOUSE)
}

viz_demand_unfacted <- function(i) {
  demand %>% select(1, 3:4418) %>%
    pivot_longer(cols = 2:i) %>% 
    mutate(
      name = as.numeric(name), # 중요 
      HOUSE = as_factor(HOUSE)
    ) %>% 
    ggplot(aes(x = name, y = value, colour = as_factor(HOUSE))) +
    geom_line() +
    labs(x = "시간", y = "수요(kWh)", colour = "HOUSE") +
    scale_x_continuous()
}
##########################################################################
##########################################################################
##########################################################################
##########################################################################
##########################################################################
demand %>% select(1, 3:4418) %>% 
  pivot_longer(cols = 2:4417) %>%
  arrange(desc(value))
viz_demand(24*10 + 1)
viz_solar(24*10 + 1)

library(tidyverse)

j = 5 # 수요 태양열 함께 나타낼 떄 일자 지정 
  
solar_and_demand <- bind_rows(solar_energy, demand)
solar_and_demand %>% pivot_longer(cols = 3:4418) %>% 
  mutate(
    HOUSE = as_factor(HOUSE),
    variables = as_factor(variables),
    name = as.numeric(name)
  ) %>% 
  ggplot(aes(x = name, y = value, colour = variables)) +
  geom_line() +
  labs(x= "시간", y = "수요, 태양열 발전", title = "",
       colour = "변수") +
  facet_wrap(~HOUSE) + 
  scale_x_continuous(limits = c(0, 24*j)) + # 그래프에 표시할 horizon 제한 
  theme(legend.text = element_text(size = 30),
        axis.title = element_text(size = 30),
        strip.text.x = element_text(size = 20))
###########################################################
elec <- electricity_data %>% 
  mutate(
    variables = ifelse(variables == "Solar Generation", "Solar",
                       variables)
  )
elec <- elec %>% mutate(variables = as_factor(variables)) 
ee <- elec %>% pivot_longer(cols = 3:4418) %>% mutate(
  HOUSE = as_factor(HOUSE)
) %>% pivot_wider(names_from = "variables",
                  values_from = "value")
ee %>% 
  ggplot(aes(x = Demand, y = Solar)) +
  geom_point() +
  facet_wrap(~HOUSE)

d <- c(95472, 69063, 61155, 43194, 35415, 30287, 29060)
t <- c(0, 25, 32.5, 50, 62.5, 75, 100)
x <- tibble(d, t)
x %>% 
  ggplot(aes(x = t, y = d)) +
  geom_point(colour = "red") +
  geom_line(colour = "red") +
  labs(x = "원 데이터 대비 태양광 발전양 비율(%)",
       y = "목적함수 값($)") +
  theme_classic() +
  theme(axis.title = element_text(size = 20))
  
