# Preparation -------------------------------------------------------------
### William Zoughaib
#### Graphical Analysis Final
#### August 8, 2020

# Load Libraries ----------------------------------------------------------
library(tidyverse)
library(here)
library(lubridate)
library(sf)
library(patchwork)
library(gghighlight)
library(ggthemes)

# Define Constants --------------------------------------------------------
first_US_case <- "19 Jan 2020"
first_MO_case <- "08 Mar 2020"
lower_48 <- c("Alabama","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming")
lower_48
Northeast_FIPS <- c(9,23,25,33,44,50,34,36,42)
Midwest_FIPS <- c(18,17,26,39,55,19,20,27,29,31,38,46)
South_FIPS <- c(10,11,12,13,24,37,45,51,54,1,21,28,47,5,22,40,48)
West_FIPS <- c(4,8,16,35,30,49,32,56,2,6,15,41,53)

# Functions ---------------------------------------------------------------




# Import & Wrangling ------------------------------------------------------
#### covid_confirmed_data
raw_covid_confirmed <- read_csv(here::here("data","covid_confirmed_usafacts.csv"))
covid_positive <- raw_covid_confirmed %>% 
  filter(countyFIPS!=0,stateFIPS!=0) %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`),names_to="date",values_to="cases") %>% 
  mutate(date=mdy(date)) %>% 
  filter(date>=dmy(first_US_case))
covid_positive
#### covid_deaths 
raw_covid_deaths <- read_csv(here::here("data","covid_deaths_usafacts.csv"))
covid_deaths <- raw_covid_deaths %>% 
  filter(countyFIPS!=0,stateFIPS!=0) %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`),names_to="date",values_to="cases") %>% 
  mutate(date=mdy(date)) %>% 
  filter(date>=dmy(first_US_case)) %>% 
  rename("deaths"=cases)
covid_deaths
#### county populations
raw_county_pop <- read_csv(here::here("data","covid_county_population_usafacts.csv"))
covid_county_pop <- raw_county_pop %>% 
  filter(countyFIPS!=0) %>% 
  rename("County_Name"=`County Name`)
covid_county_pop
#### SEMO enrollment
raw_SEMO <- read_csv(here::here("data","semo_county_enrollment.csv"),skip=1)
SEMO_county_pop <- raw_SEMO %>% 
  rename("County"=X1)
SEMO_county_pop

# Plot 1 ----------------------------------------------------
CoVid_19_data_old <- left_join(covid_positive,covid_deaths)
CoVid_region_data <- CoVid_19_data_old %>% 
  filter(date>=dmy(first_MO_case)) %>% 
  mutate(Region=case_when(
    stateFIPS%in%Northeast_FIPS~"Northeast",
    stateFIPS%in%Midwest_FIPS~"Midwest",
    stateFIPS%in%South_FIPS~"South",
    stateFIPS%in%West_FIPS~"West"
  )) %>% 
  group_by(Region,date) %>% 
  summarise(total_cases=sum(cases,na.rm=TRUE),
            total_deaths=sum(deaths,na.rm=TRUE),.groups='drop')
view(CoVid_region_data)
plot_cases <- CoVid_region_data %>% 
  ggplot()+
  geom_line(aes(x=date,y=total_cases,color=Region),size=0.75)+
  labs(x=NULL,y="Total Cases")+
  theme_test()+
  theme(legend.position = "bottom")
plot_deaths <- CoVid_region_data %>% 
  ggplot()+
  geom_line(aes(x=date,y=total_deaths,color=Region),size=0.75)+
  labs(x=NULL,y="Total Deaths")+
  theme_test()+
  theme(legend.position = "none")
plot_cases+plot_deaths+plot_layout(ncol=2)
#### Done

# Plot 2  -----------------------------------------------------------------
MO_CoVid_Cases <- covid_positive %>% 
  filter(State=="MO",date>=dmy(first_MO_case)) %>% 
  mutate(`County Name`=str_replace(`County Name`," County$",""),
         `County Name`=str_replace(`County Name`,"^Jackson ","")) %>% 
  group_by(`County Name`,date) %>% 
  summarise(total_confirmed=sum(cases,na.rm=TRUE),.groups='drop') %>% 
  rename("County"=`County Name`)
view(MO_CoVid_Cases)
## Messed around by adding rename, group_by, and summarise to the string and filter functions.  Now it looks better for left_join

SEMO_counties <- SEMO_county_pop %>% 
  mutate(`County`=str_replace(`County`,"De Kalb", "DeKalb"),
         `County`=str_replace(`County`,"^Sainte ","Ste\\. "),
         `County`=str_replace(`County`,"^Saint ","St\\. "),
         `County`=str_replace(`County`,"^St. Louis City$","City of St. Louis")) %>% 
  select(-c("2015":"2018")) 
view(SEMO_counties)

MO_CoVid_with_SEMO <- left_join(MO_CoVid_Cases,SEMO_counties)
view(MO_CoVid_with_SEMO)

MO_CoVid_with_SEMO %>% 
  ggplot()+
  geom_line(aes(x=date,y=total_confirmed,color=County))+
  labs(x=NULL,y="Total Confirmed Cases")+
  gghighlight(`2019`>=200,use_direct_label = FALSE)+
  scale_x_date(date_labels = "%d %b")
  
#### Was really confused by scale_x_date...