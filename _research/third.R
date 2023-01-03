Labour %>% as_tibble()
Labour
findout <- function(){
  OECD::search_dataset("regional", data = dataset_list)
}

dstruct_lb <- get_data_structure("REGION_LABOUR")
dstruct_lb$VAR
unique(Edu$IND)

library(OECD)
search_dataset("regional", data = dataset_list)

# EARLY_LEAVERS_RATE_Y18T24, NEAC_SHARE
dstruc_edu <- get_data_structure("REGION_EDUCAT")
dstruc_edu$GENDER
unique(Edu$REG_ID)
Edu %>% head()
unique(Edu$LOCATION)
unique(dfe$ISC11)

# EXCLU, LEAVERS, NEET, HOUSING, VEH_THEFT_RA
dstruc_soen <- get_data_structure("REGION_SOCIAL")
dstruc_soen$POS
unique(SoEn$POS)
SoEn %>% head()

dfsc %>% filter(REG_ID == "KR01") %>% filter(IND == "BB_ACC") %>% 
  arrange(POS) %>% 
  print(n = Inf)



dstruc_ST <- get_data_structure("REGION_ST")
dstruc_ST$OBS_STATUS

dfrb <- rf(RWB)
dfrb <- ff(dfrb)
dfrb <- dfrb %>% filter(obsTime == "2014")




# Only Total gender, GENDER variable == "T"
dfe <- rf(Edu)
dfe <- ff(dfe)
dfe <- dfe %>% filter(obsTime == "2014")
dfe <- dfe %>% filter(GENDER == "T")

dfe %>% filter(region == "RU") %>% print(n = Inf)
# Only total pos, POS == ALL 
dfsc <- rf(SoEn)
dfsc <- ff1(dfsc)
unique(dfsc$region)
dfsc <- dfsc %>% filter(TIME == "2014")
dfsc <- dfsc %>% filter(POS == "ALL")
dfsc <- dfsc %>% filter(TL == "2")
#
rb <- dfrb %>% select(REG_ID, IND, obsTime, obsValue, region)
ee <- dfe %>% select(REG_ID, IND, ISC11, obsTime, obsValue)
sc <- dfsc %>% select(REG_ID, IND, TIME, obsValue, region)

#
unique((dfsc %>% filter(str_detect(REG_ID, "JP")))$REG_ID)
unique((dfe %>% filter(str_detect(REG_ID, "JP")))$REG_ID)
unique((dfrb %>% filter(str_detect(REG_ID, "JP")))$REG_ID)

dfe %>% filter(str_detect(IND, "EARLY_LEAVERS_RATE_Y18T24|NEAC_SHARE")) %>% 
  pivot_wider(names_from = "IND", values_from = "obsValue") %>% 
  select(-c("LOCATION", "GENDER", 'MEAS', 'TIME_FORMAT',
            'UNIT', 'POWERCODE', 'obsTime', 'OBS_STATUS')) %>%  
  filter(ISC11 == "T")

#


###########################################################
dstruc_soen$TL

colnames(dfe)
colnames(dfsc)
colnames(dfrb)
length(unique(dfe$REG_ID))
length(unique(dfsc$REG_ID))
length(unique(dfrb$REG_ID))

temp <- dstruc_soen$REG_ID

length(unique(dfe$region))
length(unique(dfrb$region))
length(unique(dfsc$region))
unique(dfsc$region)
write.csv(temp, "soen_regid.csv")
dfe %>% filter(str_detect(region, "AU")) %>%  print(n = Inf)
dfsc %>% filter(str_detect(REG_ID, "JP")) %>% print(n = Inf)

temp <- dstruc_edu$REG_ID
write.csv(temp, "edu.regid.csv")

length(unique(dfsc$REG_ID))
length(unique(dfrb$REG_ID))


