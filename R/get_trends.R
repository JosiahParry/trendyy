#' Retrieve related queries
#'
#' Extract tibble of related queries from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_related_queries(ob)
#' }
#'
#' @return A tibble containing related search tearms
get_related_queries <- function(trendy) {
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
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_related_topics(ob)
#' }
#'
get_related_topics <- function(trendy) {
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
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest(ob)
#' }
#'
get_interest <- function(trendy) {
  map_dfr(.x = trendy, ~pluck(.x, "interest_over_time") %>%
            mutate(hits = str_extract(hits, "[0-9]+"))) %>%
    left_join(mutate(gtrendsR::categories, id = as.integer(id)),
              by = c("category" = "id")) %>%
    select(-category) %>%
    rename(category = name) %>%
    as_tibble()
}


#' Retrieve interest by city
#'
#' Extract a tibble of interest by city from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_city(ob)
#' }
#'
get_interest_city <- function(trendy) {
  map_dfr(trendy, pluck("interest_by_city")) %>%
    as_tibble()
}

#' Retrieve interest by country
#'
#' Extract a tibble of interest by country from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_country(ob)
#' }
#'
get_interest_country <- function(trendy) {
  map_dfr(trendy, pluck("interest_by_country")) %>%
    as_tibble()
}


#' Retrieve interest by DMA
#'
#' Extract a tibble of interest by DMA from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_dma(ob)
#' }
#'
get_interest_dma <- function(trendy) {
  map_dfr(trendy, pluck("interest_by_dma")) %>%
    as_tibble()
}


#' Retrieve interest by region
#'
#' Extract a tibble of interest by region from trendy object
#' @param trendy An object of class trendy created via \code{trendy()}
#'
#' @export
#' @importFrom purrr map_dfr pluck
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#' @examples
#' \dontrun{
#' ob <- trendy("obama")
#' get_interest_region(ob)
#' }

get_interest_region <- function(trendy) {
  map_dfr(trendy, pluck("interest_by_region")) %>%
    as_tibble()
}
