suppressPackageStartupMessages(library(tidyverse))

urls <- list(
  counties = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv",
  states = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"
)

dc <- suppressMessages(readr::read_csv(urls$counties))
ds <- suppressMessages(readr::read_csv(urls$states))

dc <- dc %>%
  mutate(admin0_code = "US", admin1_code = substr(fips, 1, 2)) %>%
  select(admin0_code, admin1_code, fips, date, cases, deaths) %>%
  rename(admin2_code = "fips") %>%
  filter(!is.na(admin2_code))

ds <- ds %>%
  mutate(admin0_code = "US") %>%
  select(admin0_code, fips, date, cases, deaths) %>%
  rename(admin1_code = "fips")

readr::write_csv(dc, "admin2_US.csv")
readr::write_csv(ds, "admin1_US.csv")
