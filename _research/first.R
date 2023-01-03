# whole_data <- read.csv("RWB.csv")
# whole_data %>% head()
lib_call <- function(){
  library(tidyverse)
  library(ggpmisc)
  library(ggthemes)
  library(showtext)
  font_add_google("Noto Serif KR", "notokr")
  showtext_auto()
}
# write.csv(dstruc_wb$IND, file = "regional_ind.csv")
dstruc_wb$IND
value_2014 <- df %>% filter(obsTime == 2014)
unique(value_2014$IND)
unique(df$IND)

# unit의 단위 표기 
dstruc_wb$POWERCODE

# 시간의 단위 표기 
dstruc_wb$TIME_FORMAT

# 값의 신뢰성 
dstruc_wb$OBS_STATUS

# ?
dstruc_wb$REFERENCEPERIOD
library()
search_dataset("regional", data = dataset_list)

str(RWB)
unique(RWB$IND)

# 패키지 한 번에 선언 위함 
install.packages("pacman")
basic <- c("tidyverse", "OECD")
pacman::p_load(char = basic)

# short term regional status 
ST <- get_dataset("REGION_ST")

# Social and Environmental indicators
SoEn <- get_dataset("REGION_SOCIAL")

# Regional Labour
Labour <- get_dataset("REGION_LABOUR")
??OECD
save.image("Regional_data.RData")


# Regional Education 
Edu <- get_dataset("REGION_EDUCAT")

# Regional Demography 
Demo <- get_dataset("REGION_DEMOGR")
# 22:32
Hpi <- get_dataset("RHPI")
Econ <- get_dataset("REGION_ECONOM")

