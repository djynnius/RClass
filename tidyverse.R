#installing packages
install.packages("tidyverse")

#enable a package
library(tidyverse)

nigeria <- read_csv("datasets/meningitis_dataset.csv")

#pipe

#Select columns by using the select function

names(nigeria)

select(nigeria, id, firstname, surname, age, gender, state)

#the pipe operator %>%

nigeria %>% 
  select(id, firstname, age, gender, state, surname, settlement)

#drop what you dont want
nigeria %>% select(-firstname, -surname)
  
#select can be used to rename variables
nigeria %>% 
  select(firstname, middlename, lastname=surname, age, sex=gender, settlement, state) 


nigeria %>% 
  select(firstname, middlename, lastname=surname, age, sex=gender, settlement, state) %>% 
  select(-middlename)
  

#Filter
nigeria %>% filter(state == 'Ekiti')

nigeria %>% filter(age < 18)

nigeria %>% filter(gender == 'Male')

nigeria %>% filter(age > 18 & gender == 'Male' & state == 'Ekiti')

nigeria %>% 
  filter(age > 18) %>% 
  filter(gender == 'Male') %>% 
  filter(state == 'Ekiti') %>% 
  filter(settlement == 'Urban')

#combine select and filter

nigeria %>% 
  select(id, firstname, middlename, lastname=surname, sex=gender, age, settlement, state) %>% 
  filter(age >= 18 & state == 'Ekiti' & sex == 'Male' & settlement == 'Urban')

#arrange a way to sort
nigeria %>% arrange(firstname)

nigeria %>% select(id, surname, firstname, middlename, age, gender, state) %>% arrange(age)

?arrange

nigeria %>% arrange(desc(firstname))

nigeria %>% 
  select(id, firstname, middlename, lastname=surname, sex=gender, age, settlement, state) %>% 
  filter(age >= 18 & state == 'Ekiti' & sex == 'Male' & settlement == 'Urban') %>% 
  arrange(desc(age)) -> adult.urban.males.in.ekiti

#create new data - mutate
nigeria %>% 
  select(id, firstname, middlename, lastname = surname, age, sex = gender, settlement, state) -> nigeria.mini


nigeria.mini %>% mutate(test = 'it works')

nigeria.mini %>% mutate(zone = 'unknown') -> naija

#sapply
naija[naija$state %in% c('Lagos', 'Oyo', 'Ogun', 'Ekiti', 'Osun', 'Ondo'), 'zone'] <- 'South West'
naija

#ifelse(condition, T, F)
nigeria.mini %>% 
  mutate(zone = 'unknown') %>% 
  mutate(zone = ifelse(state %in% c('Rivers', 'Cross River', 'Bayelsa', 'Akwa Ibom', 'Edo', 'Delta'), 'SS', zone)) %>% 
  mutate(zone = ifelse(state %in% c('Lagos', 'Ogun', 'Oyo', 'Osun', 'Ekiti', 'Ondo'), 'SW', zone)) %>% 
  mutate(zone = ifelse(state %in% c('Kaduna', 'Katsina', 'Kano', 'Jigawa', 'Zamfara', 'Kebbi'), 'NW', zone)) 


nigeria %>% 
  select(id, firstname, middlename, lastname=surname, sex=gender, age, settlement, state) %>% 
  filter(age >= 18 & state == 'Ekiti' & sex == 'Male' & settlement == 'Urban') %>% 
  arrange(desc(age)) %>% 
  mutate(middlename = substr(middlename, 1, 1)) %>% 
  select(id, firstname, initial=middlename, lastname, sex, age, settlement, state)

#Aggregate functions
#Hmisc

describe(nigeria.mini)


