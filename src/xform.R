suppressPackageStartupMessages(library(tidyverse))

dir.create("output", showWarning = FALSE)
dir.create("output/admin0", showWarning = FALSE)
dir.create("output/admin1", showWarning = FALSE)
dir.create("output/admin2", showWarning = FALSE)

urls <- list(
  counties = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv",
  states = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"
)

dc <- suppressMessages(readr::read_csv(urls$counties))
ds <- suppressMessages(readr::read_csv(urls$states))

country <- dc %>%
  group_by(date) %>%
  summarise(
    cases = sum(cases, na.rm = TRUE),
    deaths = sum(deaths, na.rm = TRUE))

county <- dc %>%
  mutate(admin0_code = "US", admin1_code = substr(fips, 1, 2)) %>%
  select(admin0_code, admin1_code, fips, date, cases, deaths) %>%
  rename(admin2_code = "fips") %>%
  filter(!is.na(admin2_code))

state <- ds %>%
  mutate(admin0_code = "US") %>%
  select(admin0_code, fips, date, cases, deaths) %>%
  rename(admin1_code = "fips")

readr::write_csv(county, "output/admin2/US.csv")
readr::write_csv(state, "output/admin1/US.csv")
readr::write_csv(country, "output/admin0/US.csv")
