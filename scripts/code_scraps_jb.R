# convert slides to PDF ####

# pagedown::chrome_print("slides/A1_Introduction/A1_Introduction.html")
# generates an error: Failed to generate output. Reason: Failed to open http://127.0.0.1:5044/mycss.css (HTTP status code: 404)

library(webshot)

#install_phantomjs()

file_name <- normalizePath("slides/A1_Introduction/A1_Introduction.html")
webshot(file_name, "intro_slides.pdf")

# superhero data ####

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
