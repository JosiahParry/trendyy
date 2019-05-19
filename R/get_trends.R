if(getRversion() >= "2.15.1")  {

  utils::globalVariables(c("category", "hits", "id", "keyword", "name", "pull"))
}

#' Retrieve related queries
#'
#' Extract tibble of related queries from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate rename select left_join
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_related_queries(ob)
#' }
#'
#' @return A tibble containing related search terms
get_related_queries <- function(trendy) {

  if (is.null(pluck(trendy[[1]], "related_queries"))) {
    stop("No related queries")
  }

  map_dfr(trendy, pluck("related_queries")) %>%
    left_join(mutate(gtrendsR::categories, id = as.integer(id)),
              by = c("category" = "id")) %>%
    select(-category) %>%
    rename(category = name) %>%
    as_tibble() %>%
    return()
}




#' Retrieve related topics
#'
#' Extract a tibble of related topics from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate rename select left_join
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_related_topics(ob)
#' }
#'
get_related_topics <- function(trendy) {

  if (is.null(pluck(trendy[[1]], "related_topics"))) {
    stop("No related topics")
  }

  map_dfr(trendy, pluck("related_topics")) %>%
    left_join(mutate(gtrendsR::categories, id = as.integer(id)),
              by = c("category" = "id")) %>%
    select(-category) %>%
    rename(category = name) %>%
    as_tibble() %>%
    return()
}



#' Retrieve interest over time
#'
#' Extract a tibble of interest over time
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate rename select left_join
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest(ob)
#' }
#'
get_interest <- function(trendy) {

  if (is.null(pluck(trendy[[1]], "interest_over_time"))) {
    stop("No interest over time data")
  }

  map_dfr(.x = trendy, ~pluck(.x, "interest_over_time") %>%
            mutate(hits = str_extract(hits, "[0-9]+"))) %>%
    left_join(mutate(gtrendsR::categories, id = as.integer(id)),
              by = c("category" = "id")) %>%
    select(-category) %>%
    rename(category = name) %>%
    as_tibble() %>%
    mutate(hits = as.integer(hits))
}


#' Retrieve interest by city
#'
#' Extract a tibble of interest by city from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom tibble as_tibble
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_city(ob)
#' }
#'
get_interest_city <- function(trendy) {

  if (is.null(pluck(trendy[[1]], "interest_by_city"))) {
    stop("No interest by city data")
  }

  map_dfr(trendy, pluck("interest_by_city")) %>%
    as_tibble() %>%
    mutate(hits = as.integer(hits))
}

#' Retrieve interest by country
#'
#' Extract a tibble of interest by country from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom tibble as_tibble
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_country(ob)
#' }
#'
get_interest_country <- function(trendy) {

  if (is.null(pluck(trendy[[1]], "interest_by_country"))) {
    stop("No interest by country data")
  }

  map_dfr(trendy, pluck("interest_by_country")) %>%
    as_tibble() %>%
    mutate(hits = as.integer(hits))
}


#' Retrieve interest by DMA
#'
#' Extract a tibble of interest by DMA from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_dma(ob)
#' }
#'
get_interest_dma <- function(trendy) {

  if (is.null(pluck(trendy[[1]], "interest_by_dma"))) {
    stop("No interest by DMA data")
  }

  map_dfr(trendy, pluck("interest_by_dma")) %>%
    as_tibble() %>%
    mutate(hits = as.integer(hits))
}


#' Retrieve interest by region
#'
#' Extract a tibble of interest by region from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate
#' @importFrom tibble as_tibble
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_region(ob)
#' }

get_interest_region <- function(trendy) {

  if (is.null(pluck(trendy[[1]], "interest_by_region"))) {
    stop("No interest by region data")
  }

  map_dfr(trendy, pluck("interest_by_region")) %>%
    as_tibble() %>%
    mutate(hits = as.integer(hits))
}
