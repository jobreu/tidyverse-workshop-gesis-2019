# convert slides to PDF ####

# pagedown::chrome_print("slides/A1_Introduction/A1_Introduction.html")
# generates an error: Failed to generate output. Reason: Failed to open http://127.0.0.1:5044/mycss.css (HTTP status code: 404)
# seems to be related to (additional) CSS file

library(webshot)

#install_phantomjs()

file_name <- normalizePath("slides/A1_Introduction/A1_Introduction.html")
webshot(file_name, "intro_slides.pdf")
# looks crappy
# Manual printing of HTML slides via Chrome works/looks better

# superhero data ####
library(readr)
library(dplyr)
library(stringr)

publishers <- read_csv("data/other/heroes_information.csv") %>% 
  select(Publisher) %>%
  distinct() %>% 
  filter(
    Publisher == "Marvel Comics" |
      Publisher == "DC Comics" |
      Publisher == "Image Comics"
  ) %>% 
  distinct() %>%
  mutate(Publisher = str_replace(Publisher, " Comics", ""),
         Founded = case_when(
           Publisher == "Marvel" ~ 1939L,
           Publisher == "DC" ~ 1934L,
           Publisher == "Image" ~ 1992L
         ),
         Location = case_when(
           Publisher == "Marvel" ~ "NYC (NY)",
           Publisher == "DC" ~ "Burbank (CA)",
           Publisher == "Image" ~ "Berkeley (CA)"
         ))

publishers

heroes <- read_csv("data/other/heroes_information.csv") %>% 
  select(name, Alignment, Race, Publisher) %>% 
  rename(Name = name) %>%
  distinct() %>% 
  filter(
    (Name == "Batgirl" & Race != "-") |
      Name == "Aquaman" |
      Name == "Catwoman" |
      Name == "Magneto" |
      Name == "Deadpool" |
      Name == "Poison Ivy" |
      Name == "Hellboy"
  )

heroes

# gapminder data ####
library(readr)
library(tidyr)
library(dplyr)
library(gapminder)

gapminder
min(gapminder$year)
max(gapminder$year)

gap_gdp <- read_csv("https://docs.google.com/spreadsheet/pub?key=0AkBd6lyS3EmpdHo5S0J6ekhVOF9QaVhod05QSGV4T3c&output=csv")
gap_gdp
gap_gdp <- gather(gap_gdp, key = "year", value = "gdpPercap", -"Income per person (fixed 2000 US$)") %>% 
  rename(country = "Income per person (fixed 2000 US$)") %>% 
  mutate(year = as.integer(year))
gap_gdp

gap_life <- read_csv("https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj2tPLxKvvnNPA&output=csv")
gap_life
gap_life <- gather(gap_life, key = "year", value = "lifeExp", -"Life expectancy") %>% 
  rename(country = "Life expectancy") %>% 
  mutate(year = as.integer(year))
gap_life

gap_pop <- read_csv("https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0XOoBL_n5tAQ&output=csv")
gap_pop
gap_pop <- gather(gap_pop, key = "year", value = "pop", -"Total population") %>% 
  rename(country = "Total population") %>% 
  mutate(year = as.integer(year))
gap_pop

gap_fert <- read_csv("https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=csv")
gap_fert
gap_fert <- gather(gap_fert, key = "year", value = "fertility", -"Total fertility rate") %>% 
  rename(country = "Total fertility rate") %>% 
  mutate(year = as.integer(year))
gap_fert

gap_cont <- gapminder %>% 
  select(country, continent)
gap_cont
gap_cont %>% 
  distinct()

# Titanic data
library(readr)
library(dplyr)
library(stringr)
library(rebus)
library(titanic)

titanic <- titanic_train
titanic2 <- read_csv("data/titanic/titanic.csv")

glimpse(titanic)
glimpse(titanic2)

titanic_codebook <- read_csv2("data/titanic/titanic_codebook.csv")
titanic_codebook

# function to move columns in df
# see https://stackoverflow.com/questions/52096919/move-a-column-conveniently/52096938#52096938
# also see https://github.com/tidyverse/dplyr/issues/2047
move <- function(data, cols, ref, side = c("before","after")){
  if(! requireNamespace("dplyr")) stop("Make sure package 'dplyr' is installed to use function 'move'")
  side <- match.arg(side)
  cols <- rlang::enquo(cols)
  ref  <- rlang::enquo(ref)
  if(side == "before") dplyr::select(data,1:!!ref,-!!ref,-!!cols,!!cols,dplyr::everything()) else
    dplyr::select(data,1:!!ref,-!!cols,!!cols,dplyr::everything())
}

titanic <- titanic %>% 
  separate(Name, c("last_name", "first_name"), sep =", ", remove = F) %>% 
  mutate(title = str_extract(first_name, pattern = one_or_more(ALNUM) %R% DOT)) %>% 
  mutate(first_name = str_remove(first_name, pattern = one_or_more(ALNUM) %R% DOT)) %>% 
  move(title, first_name, "after")

head(titanic)

table(titanic$title)
         