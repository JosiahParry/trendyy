<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

 <center><h2> \~trendyy\~ </h2></center>

<center> <h2> (>\^.\^)> \~ Tidy Access to Google Trends \~ <(\^.\^<) </h2></center>

`trendyy` is a package to provide a tidy interface to the [`gtrendsR`](https://github.com/PMassicotte/gtrendsR) package by [Philippe Massicotte](http://www.pmassicotte.com/). 

The idea was to provide an interface to the package that is `tibble` friendly. This package provides accessor functions to the various data frames that `gtrendsR` provides. 

### Usage:

`trendy()` enables you to query Google Trends. The only required argument is `search_terms`. If you submit 5 or few search terms as a character vector, the terms will be compared to eachother. If more than 5 terms are submitted, each will be qeuried on it's own. 

Optionally, you can provide a desired date range in the format of `"YYYY-MM-DD"` to the `from` and `to` arguments. Other arguments that are passed to `gtrendsR::gtrends()` are also valid, including the `time` argument. 

`trendy()` returns an object of class `trendy`. To access the tables, use any of the accessor functions below:

- `get_interest()`: trends over time
- `get_interest_city()`: trends by city
- `get_interest_country()`: trends by country
- `get_interest_dma()`:  trends for a designated marketing area
- `get_interest_region()`: trends by region
- `get_related_queries()`: related search phrases
- `get_related_topics()`: related topics


### Example:

```
library(trendyy)
library(dplyr)



ob <- trendy("Obama", 
             from = Sys.Date() - 365,
             to = Sys.Date()) %>% 
        get_interest()
```
