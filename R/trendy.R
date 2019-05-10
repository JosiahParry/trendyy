trendy <- function(search_terms, from = NA, to = NA, ...) {

  searched_trends <- search_terms %>%
    map(gtrends, ...)

  structure(
    searched_trends,
    class = "trendy"
          )

}


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


