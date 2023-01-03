library(tidyverse)
library(readxl)
list.files()

original <- read_excel("ilsanon_response.xlsx")

original %>% head()


mdata <-  original %>% select(-c(1,2)) 
mdata <- mdata[-3,]
colnames(mdata %>% select(-c(16:20)))

colnames(mdata)

# 도입 설문 
introduction <- mdata %>% select(c(1:3))
# 읽기 설문 
reading <- mdata %>% select(c(4:6))
# 토론 활동 설문 
debate <- mdata %>% select(c(7:8))
# 영상 클립 설문 
video <- mdata %>% select(c(9:11))
# 학습지 설문 
material <- mdata %>% select(c(12:15))

reading <- bind_cols(num_scores_value$reading_score, reading)
debate <- bind_cols(num_scores_value$debate_score, debate)
video <- bind_cols(num_scores_value$video_score, video)
material <- bind_cols(num_scores_value$material_score, material)
reading

colnames(reading) <- c("score", "reading_score")
colnames(debate) <- c("score","debate_score")
colnames(video) <- c("score","video_score")
colnames(material) <- c("score","material_score")

install.packages("writexl")
library(writexl)
write_xlsx(reading, "읽기 설문.xlsx")
write_xlsx(debate, "토론 설문.xlsx")
write_xlsx(video, "영상 설문.xlsx")
write_xlsx(material, "학습지 설문.xlsx")

scores <- bind_cols(reading %>% select(c(1)),
          debate %>% select(c(1)),
          video %>% select(c(1)),
          material %>% select(c(1)),)

mod_scores <- tibble()


for(i in colnames(scores)){
  
  temp <- scores %>% select(i) %>%
    mutate(
      i = ifelse(str_detect(i,"많은 도움"), 5, i),
      i = ifelse(str_detect(i,"정도 도움"), 4, i),
      i = ifelse(str_detect(i,"잘"), 3, i),
      i = ifelse(str_detect(i,"별로 도움"), 2, i),
      i = ifelse(str_detect(i,"전혀 도움"), 1, i),
    )
  mod_scores <- bind_cols(scores, temp)
}  

r_score <- scores %>% select(c(1)) %>%
  mutate(
    reading_score = ifelse(str_detect(reading_score,"많은 도움"), 5, reading_score),
    reading_score = ifelse(str_detect(reading_score,"정도 도움"), 4,reading_score),
    reading_score = ifelse(str_detect(reading_score,"잘"), 3,reading_score),
    reading_score = ifelse(str_detect(reading_score,"별로 도움"), 2,reading_score),
    reading_score = ifelse(str_detect(reading_score,"전혀 도움"), 1,reading_score),
  )

d_score <- scores %>% select(c(2)) %>%
  mutate(
    debate_score = ifelse(str_detect(debate_score,"많은 도움"), 5, debate_score),
    debate_score = ifelse(str_detect(debate_score,"정도 도움"), 4,debate_score),
    debate_score = ifelse(str_detect(debate_score,"잘"), 3,debate_score),
    debate_score = ifelse(str_detect(debate_score,"별로 도움"), 2,debate_score),
    debate_score = ifelse(str_detect(debate_score,"전혀 도움"), 1,debate_score),
  )



v_score <- scores %>% select(c(3)) %>%
  mutate(
    video_score = ifelse(str_detect(video_score,"많은 도움"), 5, video_score),
    video_score = ifelse(str_detect(video_score,"정도 도움"), 4,video_score),
    video_score = ifelse(str_detect(video_score,"잘"), 3,video_score),
    video_score = ifelse(str_detect(video_score,"별로 도움"), 2,video_score),
    video_score = ifelse(str_detect(video_score,"전혀 도움"), 1,video_score),
  )


m_score <- scores %>% select(c(4)) %>%
  mutate(
    material_score = ifelse(str_detect(material_score,"많은 도움"), 5, material_score),
    material_score = ifelse(str_detect(material_score,"정도 도움"), 4,material_score),
    material_score = ifelse(str_detect(material_score,"잘"), 3,material_score),
    material_score = ifelse(str_detect(material_score,"별로 도움"), 2,material_score),
    material_score = ifelse(str_detect(material_score,"전혀 도움"), 1,material_score),
  )

rm(num_scores)
# 항목별 수치 계산 
num_scores <- bind_cols(r_score, d_score)
num_scores <- bind_cols(num_scores, v_score)
num_scores <- bind_cols(num_scores, m_score)
num_scores_value <- num_scores %>% mutate(
  reading_score = as.numeric(reading_score),
  debate_score = as.numeric(debate_score),
  video_score = as.numeric(video_score),
  material_score = as.numeric(material_score),
)

num_scores <- num_scores %>% mutate(
  reading_score = as_factor(reading_score),
  debate_score = as_factor(debate_score),
  video_score = as_factor(video_score),
  material_score = as_factor(material_score),
)

library(ggthemes)
num_scores_value %>% summarise(across(c(1:4), mean))
num_scores_value %>% summarise(across(c(1:4), sd))
num_scores_value %>% 
  ggplot(aes(x = reading_score, y = ..count.., fill = reading_score)) +
  geom_bar(aes(fill = reading_score)) +
  scale_x_continuous(n.breaks = 6, limits = c(0.5,5.5)) +
  geom_text(stat = "count", aes(label=..count..), vjust=-1) +
  theme_tufte()
r_score$reading_score <- factor(r_score$reading_score, levels = c("1","2","3","4","5"))
d_score$debate_score <- factor(d_score$debate_score, levels = c("1","2","3","4","5"))
v_score$video_score <- factor(v_score$video_score, levels = c("1","2","3","4","5"))
m_score$material_score <- factor(m_score$material_score, levels = c("1","2","3","4","5"))
levels(r_score$reading_score)

####################################################################################
r_score %>% ggplot(aes(x = reading_score, fill = reading_score)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE) + 
  geom_text(stat = "count", aes(label=..count..), vjust=-1) +
  theme_minimal() +
  theme(legend.position = "none", 
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.y=element_blank(),
        text = element_text(size = 30)) +
  labs(x ="읽기 자료 효용 점수")
ggsave("읽기자료효용점수.png")

m_score %>% ggplot(aes(x = material_score, fill = material_score)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE) + 
  geom_text(stat = "count", aes(label=..count..), vjust=-1) +
  theme_minimal() +
  theme(legend.position = "none", 
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.y=element_blank(),
        text = element_text(size = 30)) +
  labs(x ="학습지 자료 효용 점수")
ggsave("학습지자료효용점수.png")
v_score %>% ggplot(aes(x = video_score, fill = video_score)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE) + 
  geom_text(stat = "count", aes(label=..count..), vjust=-1) +
  theme_minimal() +
  theme(legend.position = "none", 
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.y=element_blank(),
        text = element_text(size = 30)) +
  labs(x ="영상 자료 효용 점수")
ggsave("영상자료효용점수.png")
d_score %>% ggplot(aes(x = debate_score, fill = debate_score)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE) + 
  geom_text(stat = "count", aes(label=..count..), vjust=-1) +
  theme_minimal() +
  theme(legend.position = "none", 
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.y=element_blank(),
        text = element_text(size = 30)) +
  labs(x =" 토론 효용 점수")
ggsave("토론효용점수.png")
