install.packages("httpgd")
httpgd::hgd()
httpgd::hgd_view()
set.seed(1200)
library(tidyverse)
temp <- as_tibble(runif(10000))
temp %>%
  ggplot(aes(x = value))+
  geom_freqpoly(colour = "red")
getwd()
