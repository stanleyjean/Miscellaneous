load("C:\\WORK\\_research\\save\\data.RData")
library(tidyverse)
library(ggthemes)
library(ggpmisc)
str(RWB)
RWB$IND
dstruc_wb$IND
unique(RWB$IND)

# SUBJ_SOC_SUPP
# SUBJ_LIFE_SAT Self-evaluation of life satisfaction
# INCOME_DISP disposable income per capita
# EDU38_SH at least secondary education 
# STD_MORT Standardised mortality rate
# LIFE_EXP life expectancy 
# VOTERS_SH  Voter turnout in general election

# RWB has only annual values, normal units no multipler 
# 2000, 2010, 2014 
dstruc_wb$REG_ID

# RWB organised 
df <- RWB %>% select(-c(3:4, 6))
# df <- df %>% filter(IND == "VOTERS_SH" |
#                 IND == "SUBJ_SOC_SUPP" |
#                 IND == "SUBJ_LIFE_SAT" |
#                 IND == "INCOME_DISP" |
#                 IND == "EDU38_SH" |
#                 IND == "STD_MORT" |
#                 IND == "LIFE_EXP")
df <- df %>% filter(obsTime == "2014")
df <- df %>% filter(str_detect(REG_ID, "JP|KR|UK|US|FR|IT|AU|DE"))
df <- df %>% arrange(REG_ID)
unique(df$REG_ID)
write.csv(dstruc_wb$REG_ID, "reg_id.csv")
# AUS, AUT, DEU, FRA, ITA, JPN, 

# 일본, 한국, 영국, 미국, 프랑스, 이태리, 호주, 독일 
dfrr <- df %>% filter(REG_ID != "AUS|AUT|DEU|FRA|ITA|JPN")
unique(dfrr$IND)

dfrr <- dfrr %>% mutate(
  region = str_sub(REG_ID, start = 1, end = 2)
)

dfrr <- dfrr %>% mutate(
  REG_ID = as_factor(REG_ID),
  IND = as_factor(IND),
  region = as_factor(region)
)
unique(dfrr$IND)

dfrr %>% select(-UNIT) %>% # 유닛 제거하고 
  pivot_wider(names_from = "IND", values_from = "obsValue") %>% 
  mutate(
    INCOME_DISP = log(INCOME_DISP)
  ) %>% 
  # filter(region == "JP") %>% 
#filter(str_detect(region, "KR")) %>%
  ggplot(aes(x = EDU38_SH, y = SUBJ_LIFE_SAT)) +
  geom_point(aes(colour = region)) + 
  geom_smooth(se = F, method = "lm") +  
  scale_colour_colorblind() + theme_few() +
  stat_poly_eq() 
check %>%
  mutate(
    INCOME_DISP = log(INCOME_DISP)
  ) %>% 
  # filter(region == "JP") %>% 
  #filter(str_detect(region, "KR")) %>%
  ggplot(aes(x = EMP_RA, y = SUBJ_LIFE_SAT)) +
  geom_point(aes(colour = region)) + 
  geom_smooth(se = F, method = "lm") +  
  scale_colour_colorblind() + theme_few() +
  stat_poly_eq() 
check <- dfrr %>% select(-UNIT) %>% # 유닛 제거하고 
  pivot_wider(names_from = "IND", values_from = "obsValue") 
check
summary(check %>% aov(SUBJ_LIFE_SAT ~ INCOME_DISP, data = .))
library(httpgd)
httpgd::hgd()
httpgd::hgd_browse()
httpgd::hgd_view()

hgd_close()
install.packages("ggpmisc")
library(ggpmisc)
library(tidyverse)
library(ggthemes)

####################################
rf <- function(x){
y <- x %>% filter(str_detect(REG_ID, 
                               "JP|KR|UK|US|FR|IT|AU|DE")) %>%
    filter(!str_detect(REG_ID, "AUS|AUT|DEU|FRA|ITA|JPN|USA")) %>% 
    mutate(region = str_sub(REG_ID, start = 1, end = 2)) %>%
    arrange(region)
  return(y)
}
ff <- function(x){
  y <- x %>% arrange(REG_ID) %>% mutate(
    REG_ID = as_factor(REG_ID),
    IND = as_factor(IND),
    region = as_factor(region)
  )
  return(y)
}

ff1 <- function(x){
  y <- x %>% arrange(REG_ID) %>% mutate(
    REG_ID = as_factor(REG_ID),
    IND = as_factor(VAR),
    region = as_factor(region)
  ) %>% select(-VAR)
  return(y)
}
########################################################
df1 <- RWB %>% select(-c(3:4, 6))
dfrr1 <- df1 %>%  filter(str_detect(REG_ID, 
                                  "JP|KR|UK|US|FR|IT|AU|DE"))
unique(dfrr1$REG_ID)
dfrr1 <- dfrr1 %>% filter(!str_detect(REG_ID,"AUS|AUT|DEU|FRA|ITA|JPN")) %>%
  arrange(REG_ID)

dfrr1 <- dfrr1 %>% mutate(
  region = str_sub(REG_ID, start = 1, end = 2)
)

dfrr1 <- dfrr1 %>% mutate(
  REG_ID = as_factor(REG_ID),
  IND = as_factor(IND),
  region = as_factor(region)
)
dfrr1
dfrr1 <- dfrr1 %>% filter(obsTime == "2000") %>% 
  select(-UNIT) %>% # 유닛 제거하고 
  pivot_wider(names_from = "IND", values_from = "obsValue")
dfrr1 %>% 
  mutate(
    INCOME_DISP = log(INCOME_DISP)
  ) %>%
  ggplot(aes(x = INCOME_DISP, y = SUBJ_LIFE_SAT)) +
  geom_point(aes(colour = region)) +
  geom_smooth(method = "lm", se = F) +
  stat_poly_eq()
unique(dfrr1)
dstruc_wb$IND

Edu %>% head

hgd_
