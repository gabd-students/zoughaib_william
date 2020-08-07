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
#### For Plot 4
new_cases <- function(args) {
  length_args <- length(args) 
  day_before <- c(0, args[1:length_args - 1])
  diff <- args - day_before
  return(diff)
}         



# Import & Wrangling ------------------------------------------------------
#### covid_confirmed_data
raw_covid_confirmed <- read_csv(here::here("data","covid_confirmed_usafacts.csv"))
covid_positive <- raw_covid_confirmed %>% 
  filter(countyFIPS!=0,stateFIPS!=0) %>% 
  pivot_longer(c(`1/22/20`:`7/31/20`),names_to="date",values_to="cases") %>% 
  mutate(date=mdy(date)) %>% 
  filter(date>=dmy(first_US_case))
view(covid_positive)
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
  filter(countyFIPS!=0) 
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
## Done

# Plot 2  -----------------------------------------------------------------
MO_CoVid_Cases <- covid_positive %>% 
  filter(State=="MO",date>=dmy(first_MO_case)) %>% 
  mutate(`County Name`=str_replace(`County Name`," County$",""),
         `County Name`=str_replace(`County Name`,"^Jackson ","")) %>% 
  group_by(`County Name`,date) %>% 
  summarise(total_confirmed=sum(cases,na.rm=TRUE),.groups='drop') %>% 
  rename("County"=`County Name`)
view(MO_CoVid_Cases)
#### Messed around by adding rename, group_by, and summarise to the string and filter functions.  Now it looks better for left_join

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
  geom_line(aes(x=date,y=total_confirmed,color=County),size=0.6)+
  labs(x=NULL,y="Total Confirmed Cases")+
  gghighlight(`2019`>=200,use_direct_label = FALSE)+
  scale_x_date(date_labels = "%d %b")+ 
  theme_test()
  
#### Was really confused by scale_x_date..., messed around with size font but still looks jaggedy
##Done

# Plot 3 ------------------------------------------------------------------
CoVid_A<- covid_positive %>% 
  filter(date%in%c(ymd("2020-04-01"),ymd("2020-07-01"))) %>% 
  rename(cases_first=cases,date_first=date) %>% 
  group_by(State,date_first) %>% 
  summarise(cases_first=sum(cases_first)) 
   

CoA <- CoVid_A %>% 
  filter(date_first==ymd("2020-04-01"))
CoB <- CoVid_A %>% 
  filter(date_first==ymd("2020-07-01"))

CoVid_B <- covid_positive %>% 
  filter(date%in%c(ymd("2020-04-30"),ymd("2020-07-30"))) %>% 
  rename(cases_last=cases,date_last=date) %>% 
  group_by(State,date_last) %>% 
  summarise(cases_last=sum(cases_last)) 

CoVA <- CoVid_B %>% 
  filter(date_last==ymd("2020-04-30"))
CoVB <- CoVid_B %>% 
  filter(date_last==ymd("2020-07-30"))
  
CoVid_pop <- covid_county_pop %>% 
  group_by(State) %>% 
  summarise(population=sum(population))


CoVid_last <- left_join(CoVB,CoB) %>% 
  mutate(new_cases=cases_last-cases_first) %>% 
  left_join(CoVid_pop) %>% 
  mutate(case_rate=(new_cases/population)*100000) %>% 
  arrange(case_rate)
order_states <- CoVid_last$State
order_states <- factor(order_states,ordered=TRUE)
CoVid_first <- left_join(CoVA,CoA) %>% 
  mutate(new_cases=cases_last-cases_first) %>% 
  left_join(CoVid_pop) %>% 
  mutate(case_rate=(new_cases/population)*100000) %>% 
  arrange(case_rate)
Overall_CoVid <- CoVid_first %>% 
  rbind(CoVid_last) %>% 
  mutate(Month=month(date_first,label=TRUE,abbr=TRUE),
         State=factor(State,ordered = TRUE,levels=order_states)) %>% 
  select(Month,State,case_rate)
view(Overall_CoVid)

Overall_CoVid %>% 
  ggplot(aes(x=State,y=case_rate),group=State) +
  geom_line(color="grey66")+
  geom_point(aes(fill=Month,shape=Month),size=1.5)+
  coord_flip()+
  scale_shape_manual(values=c(23:24))+
  scale_fill_brewer(palette = "Dark2")+
  theme_minimal()+
  theme(legend.position = "none",
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())+
  labs(x=NULL,y="COVID-19 cases (per 100,000) for|nApril(squares) & July(circles)")
#### I would like to credit this to Afreen.  She finally figured it out as we had been communicating a bit via GroupMe.  
#### I literally started this on Tuesday, glad I did not start this afternoon and make it really last minute.....
# Plot 4 ------------------------------------------------------------------
MO_CoVid_Cases <- covid_positive %>% 
  filter(State=="MO",date>=dmy(first_MO_case)) %>% 
  mutate(`County Name`=str_replace(`County Name`," County$",""),
         `County Name`=str_replace(`County Name`,"^Jackson ","")) %>% 
  group_by(date) %>% 
  summarise(total_confirmed=sum(cases,na.rm=TRUE),.groups='drop') %>% 
  mutate(daily=new_cases(`total_confirmed`)) 
view(MO_CoVid_Cases)

MO_CoVid_Cases$roll_mean <- 
  data.table::frollmean(MO_CoVid_Cases$daily,7,align="right") %>% 
  replace_na(0)

MO_CoVid_Cases %>% 
  ggplot(aes(x=date,y=daily))+
  geom_col(color="grey55",fill="grey85")+
  geom_line(aes(x=date,y=roll_mean),
            color="#9D2235",
            size=0.60)+
  geom_col(data=filter(MO_CoVid_Cases,date == dmy("16 June 2020")),
           mapping = aes(x = date, y = daily),
           color = "gray85",
           fill = "#C8102E")+
  scale_x_date(date_labels = "%b%d",
               date_breaks = "2 weeks")+
  theme_test()+
  annotate(geom="text",x=mdy("Jun 16 2020"),y=228,label="Missouri reopened\n16 June 2020",color="#C8102E",fill="C8102E")+
  labs(x=NULL,y="Daily New Cases")
#### I cant figure out how to adjust the annotation.  I tried hjust and vjust.  

# Plot 5 ------------------------------------------------------------------
CoVid_death_rate <- covid_deaths %>% left_join(covid_positive) %>% 
  filter(date==mdy("July 31,2020")) %>% 
  group_by(State) %>% 
  summarise(`Total Deaths`=sum(deaths,na.rm=TRUE),
            `Total Cases`=sum(cases,na.rm=TRUE),.groups='drop') %>% 
  mutate("Death rate (%)"=`Total Deaths`/`Total Cases`*100)
view(CoVid_death_rate)
CoVid_Table <- CoVid_death_rate %>% 
                     filter(`Death rate (%)` >= 5) %>% 
                     arrange(desc(`Death rate %`))
CoVid_Table

states <- st_read(here::here("data/shape_files","cb_2017_us_state_500k.shp"),stringsAsFactors = TRUE)
states_CoVid <- states %>%
  dplyr::filter(NAME %in% lower_48) %>%
  rename(State= STUSPS)
states_CoVid_all <- left_join(states_CoVid,CoVid_death_rate)  


library(RColorBrewer)
states_CoVid_all %>% 
ggplot()+
  geom_sf(aes(fill=`Death rate (%)`))+
  scale_fill_viridis_c(name="COVID-19 Death rate,\n% of confirmed cases",
                       option="inferno")+
  coord_sf(crs=st_crs(5070))+
  theme_bw()+
  theme(legend.position = "bottom")

#### FINALLY FINISHED WITH PLOT 5 (MY VERSION) EVEN THOUGH I DID NOT NEED TO DO IT...



## THE END