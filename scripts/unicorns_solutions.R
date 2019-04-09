library(dplyr)
library(readxl)

# read in data ####
observations <- read_excel("data/unicorns/observations.xlsx")
sales <- read_excel("data/unicorns/sales.xlsx")

glimpse(observations)
glimpse(sales)

# What is strange here?

?read_excel

# Fix this
sales <- read_excel("data/unicorns/sales.xlsx",  range = cell_cols("A:C")) %>% 
    bind_cols(read_excel("data/unicorns/sales.xlsx",  range = cell_cols("H")))

sales
observations

# Prepare for merging ####
observations %>% 
    select(countryname) %>% 
    distinct()

sales %>% 
    select(countryname) %>% 
    distinct()

sales <- sales %>% 
    rename(countryname = name_of_country) %>% 
    mutate(countryname = recode(countryname, "AUSTRIA" = "Austria",
                                "FRANCE" = "France",
                                "GERMANY" = "Germany",
                                "NETHERLANDS" = "Netherlands",
                                "SWITZERLAND" = "Switzerland"))

sales
observations

# Join datasets ####
unicorns <- observations %>% 
    full_join(sales, by = c("countryname", "year"))

unicorns

# Filter cases ####
# Let's say we are only interested in German-speaking countries
observations_ger <- observations %>% 
    filter(countryname != "France" & countryname != "Netherlands")
# present/discuss other/alternative filter operations?

observations_ger

# Select variables ####
total <- sales %>% 
    select(-bikes)
# present/discuss other/alternative variants of select?

total
