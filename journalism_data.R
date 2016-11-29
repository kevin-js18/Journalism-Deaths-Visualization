library(ggplot2)
library(dplyr)
library(readr)
library(rworldmap)
set.seed(8000)

# Database url
url <- "C:/Users/aet/Desktop/School/R projects/Journalism data/data/cpj.csv"

# Working with data

journalist_data <- read_csv(url)

glimpse(journalist_data)

journalist_data <- select(journalist_data, -1, -3, -6, -8, -10, -11, -12)

journalist_data <- select(journalist_data, -(8:11))

glimpse(journalist_data)

unique(journalist_data$Job)

deaths_by_country <- journalist_data %>%
  select(contains("Country_killed")) %>%
  group_by(Country_killed) %>%
  summarize(Deaths = n())

options(tibble.print_max = Inf)
deaths_by_country$Country_killed[11] <- "Bosnia and Herzegovina"
deaths_by_country$Country_killed[50] <- "Israel"
deaths_by_country$Country_killed[99] <- "United States"
deaths_by_country$Country_killed[96] <- "United Kingdom"
deaths_by_country <- deaths_by_country[-104, ]
deaths_by_country$Deaths[80] <- 13

map <- joinCountryData2Map(deaths_by_country, joinCode = "NAME", nameJoinColumn = "Country_killed", verbose = TRUE)

mapCountryData(map, nameColumnToPlot = "Deaths", mapTitle = "Journalist Deaths by Country, 1992 - 2016", missingCountryCol = "grey", catMethod = c(0, 5, 10, 20, 50, 75, 100, 150, 200, 270), borderCol = "black")

