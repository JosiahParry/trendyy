library(gtrendsR)
library(tidyverse)


searches <- c("Cory Booker", "Elizabeth Warren", "Bernie Sanders", "Joe Biden",
              "Kamala Harris", "Andrew Yang", "Julian Castro", "Bill Weld")



x <- searches[1:3] %>%
  map(gtrends)

map_dfr(x, pluck("related_topics"))




get_related_queries <- function(gtrend) {
  map_dfr(gtrend, pluck("related_queries")) %>%
    left_join(mutate(categories, id = as.integer(id)),
              by = c("category" = "id")) %>%
    select(-category) %>%
    rename(category = name) %>%
    return()
}

get_related_queries(x)

get_related_topics <- function(gtrend) {
  map_dfr(gtrend, pluck("related_topics")) %>%
    left_join(mutate(categories, id = as.integer(id)),
              by = c("category" = "id")) %>%
    select(-category) %>%
    rename(category = name) %>%
    return()
}

get_related_topics(x)

get_interest_dma <- function(gtrend) {
 map_dfr(gtrend, pluck("interest_by_dma"))
}

get_interest_dma(x)

get_interest <- function(gtrend) {
  map_dfr(.x = gtrend, ~pluck(.x, "interest_over_time") %>%
            mutate(hits = str_extract(hits, "[0-9]+")))
}


get_interest(x)

get_interest_country <- function(gtrend) {
  map_dfr(gtrend, pluck("interest_by_country"))
}


get_interest_country(x)


get_interest_city <- function(gtrend) {
  map_dfr(gtrend, pluck("interest_by_city"))
}


get_interest_city(x)


get_interest_region <- function(gtrend) {
  map_dfr(gtrend, pluck("interest_by_region"))
}

get_interest_region(x)


