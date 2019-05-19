#' Create print method for trendy object
#' @name trendy
#' @param x trendy object
#' @importFrom dplyr pull group_by summarise
#' @export
print.trendy <- function(x, ...) {
  cat((crayon::bold("~Trendy results~\n")))
  cat("\nSearch Terms: ")
  cat(paste(get_interest(x) %>%
              dplyr::pull(keyword) %>%
              unique(),
            sep = " "), sep = ", ")
  cat("\n\n(>^.^)> ~~~~~~~~~~~~~~~~~~~~ summary ~~~~~~~~~~~~~~~~~~~~ <(^.^<)\n")
  print(x %>%
          get_interest() %>%
          group_by(keyword) %>%
          summarise(max_hits = max(hits),
                    min_hits = min(hits),
                    from = as.Date(min(date)),
                    to = as.Date(max(date))))
  invisible(x)
}


