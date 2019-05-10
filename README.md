<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

## \~trendy\~

`trendy` is a package to provide a tidy interface to the [`gtrendsR`](https://github.com/PMassicotte/gtrendsR) package by [Philippe Massicotte](http://www.pmassicotte.com/). 

The idea was to provide an interface to the package that is `tibble` friendly. This package provides accessor functions to the various data frames that `gtrendsR` provides. These are:

- `get_interest()`: trends over time
- `get_interest_city()`: trends by city
- `get_interest_country()`: trends by country
- `get_interest_dma()`:  trends for a designated marketing area
- `get_interest_region()`: trends by region
- `get_related_queries()`: related search phrases
- `get_related_topics()`: related topics

