# A slightly modified version of gtrends
gtrends <- function(
  keyword = NA,
  geo = "",
  time = "today+5-y",
  gprop = c("web", "news", "images", "froogle", "youtube"),
  category = 0,
  hl = "en-US",
  low_search_volume = FALSE,
  cookie_url = "http://trends.google.com/Cookies/NID",
  tz=0, # This equals UTC
  onlyInterest=FALSE
) {
  stopifnot(
    # One  vector should be a multiple of the other
    (length(keyword) %% length(geo) == 0) || (length(geo) %% length(keyword) == 0) || (length(time) %% length(keyword) == 0),
    is.vector(keyword),
    length(keyword) <= 5,
    length(geo) <= 5,
    length(time) <= 5,
    length(hl) == 1,
    is.character(hl),
    hl %in% language_codes$code,
    length(cookie_url) == 1,
    is.character(cookie_url)
  )


  ## Check if valide geo
  if (geo != "" &&
      !all(geo %in% c(as.character(countries[, "country_code"]), as.character(countries[, "sub_code"])))) {
    stop(
      "Country code not valid. Please use 'data(countries)' to retreive valid codes.",
      call. = FALSE
    )
  }

  ## Check if valide category
  if (!all(category %in% categories[, "id"])) {
    stop(
      "Category code not valid. Please use 'data(categories)' to retreive valid codes.",
      call. = FALSE
    )
  }

  ## Check if time format is ok
  if (!check_time(time)) {
    stop("Cannot parse the supplied time format.", call. = FALSE)
  }

  if(!(is.numeric(tz))){
    if (tz %in% OlsonNames()){
      tz <- map_tz2min(tz)
    }else{
      stop("Given timezone not known. Check function OlsonNames().", call. = FALSE)
    }
  }

  # time <- "today+5-y"
  # time <- "2017-02-09 2017-02-18"
  # time <- "now 7-d"
  # time <- "all_2006"
  # time <- "all"
  # time <- "now 4-H"
  # geo <- c("CA", "FR", "US")
  # geo <- c("CA", "DK", "FR", "US", "CA")
  # geo <- "US"

  gprop <- match.arg(gprop, several.ok = FALSE)
  gprop <- ifelse(gprop == "web", "", gprop)

  # ****************************************************************************
  # Request a token from Google
  # ****************************************************************************
  comparison_item <- data.frame(geo, time,keyword, stringsAsFactors = FALSE)

  widget <- get_widget(comparison_item, category, gprop, hl, cookie_url,tz)
  my_widget <<- widget

  # ****************************************************************************
  # Now that we have tokens, we can process the queries
  # ****************************************************************************

  interest_over_time <- interest_over_time(widget, comparison_item,tz)

  if(!onlyInterest){
    interest_by_region <- interest_by_region(widget, comparison_item, low_search_volume,tz)
    related_topics <- related_topics(widget, comparison_item, hl,tz)
    related_queries <- related_queries(widget, comparison_item,tz)


    res <- list(
      # convert all to a tibble
      interest_over_time = interest_over_time %>% as_tibble(),
      interest_by_country = interest_by_region[["country"]] %>% as_tibble(),
      interest_by_region = interest_by_region[["region"]] %>% as_tibble(),
      interest_by_dma = interest_by_region[["dma"]] %>% as_tibble(),
      interest_by_city = interest_by_region[["city"]] %>% as_tibble(),
      related_topics = as_tibble(related_topics),
      related_queries = as_tibble(related_queries),
      search_terms = keyword
    )


  }else{
    res <- list(interest_over_time = interest_over_time)
  }

  ## Remove row.names
  res <- lapply(res, function(x) {
    row.names(x) <- NULL
    x
  })

  class(res) <- c("gtrends", "list")

  return(res)
}


# Create print method for trendy object
print.trendy <- function(x) {
  cat((crayon::bold("~Trendy results~\n")))
  cat("\nSearch Terms: ")
  cat(paste(map_chr(x, pluck("search_terms")), sep = " "), sep = ", ")
  cat("\n\n(>'-')> ~~~~~~~~~~~~~~~~~~~~ Summary ~~~~~~~~~~~~~~~~~~~~ <('-'<)\n")
  print(x %>%
          get_interest() %>%
          group_by(keyword) %>%
          summarise(max_hits = max(hits),
                    min_hits = min(hits),
                    from = as.Date(min(date)),
                    to = as.Date(max(date))))
  invisible(x)
}


