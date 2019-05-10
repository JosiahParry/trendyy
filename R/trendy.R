#' Google Trends Search
#'
#' Search Google Trends to retrieve relative hits and popularity. Note that this does not have the ability to compare trends as gtrendsR does (yet).
#'
#' @param search_terms A character vector containing the search terms of interest
#' @param from The beginning date of the query
#' @param to The beginning date of the query
#' @param ... arguments passed to \code{gtrendsR::gtrends()}. See ?gtrendsR::gtrends for more information including geography, language, and time-zone.
#'
#' @export
#' @importFrom purrr map map_chr pluck
#' @importFrom dplyr group_by summarise
#' @importFrom crayon bold
#' @return An object of class `trendy`
#'
#' @examples
#' \dontrun{
#' trendy("RStudio 1.2")
#' }
#'

trendy <- function(search_terms, from = NA, to = NA, ...) {

  if (!all(is.na(from), is.na(to))) {
    time <- paste(from, to, sep = " ")
  } else {
    time <- "today+5-y"
  }

  searched_trends <- search_terms %>%
    map(gtrendsR::gtrends, time = time, ...)

  searched_terms["search_terms"] <- search_terms

  structure(
    searched_trends,
    class = "trendy"
          )

}
