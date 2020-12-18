#install all packages
install.packages("devtools")
install.packages("tidyverse")
install.packages("visdat")
install.packages("skimr")

install.packages("opendatatoronto")
devtools::install_github("sharlagelfand/opendatatoronto")

library(opendatatoronto)
library(tidyverse)
library(visdat)
library(skimr)
library(dplyr)
library(ggplot2)

package<-show_package("64b54586-6180-4485-83eb-81e8fae3b8fe")
package

resources<-list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe")

#change data resources format from TORONTO OPEN DATA format to CSV and GEOJSON
data_resources<-filter(resources, tolower(format) %in% c('csv','geojson'))

#load the data 
data<-filter(data_resources, row_number()==1) %>% get_resource()
data

#show types of all the data
glimpse(data)

# data cleaning
COVID_19_in_Toronto=data %>% 
  select(`Episode Date`,Assigned_ID, Classification, `Age Group`,`Client Gender`,`Source of Infection`, `Neighbourhood Name`) %>%
  arrange(`Episode Date`)

# remove N/A 
COVID_19_in_Toronto=na.omit(COVID_19_in_Toronto)

# change variable "Classification" to numberical
COVID_19_in_Toronto$Classification=ifelse(COVID_19_in_Toronto$Classification != "CONFIRMED",1,0)

glimpse(COVID_19_in_Toronto)


