suppressPackageStartupMessages(library(tidyverse))

urls <- list(
  counties = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv",
  states = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"
)

dc <- suppressMessages(readr::read_csv(urls$counties))
ds <- suppressMessages(readr::read_csv(urls$states))

dc <- dc %>%
  mutate(fips_state = substr(fips, 1 , 2)) %>%
  select(fips, fips_state, date, cases, deaths) %>%
  rename(fips_county = "fips")

dc %>%
  group_by(fips_county) %>%
  summarise(dt = min(date))

ds <- ds %>%
  select(fips, date, cases, deaths) %>%
  rename(fips_state = "fips")

readr::write_csv(dc, "admin2_US.csv")
readr::write_csv(ds, "admin1_US.csv")
