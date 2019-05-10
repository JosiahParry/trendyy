# Create print method for trendy object
#' @export
print.trendy <- function(x, ...) {
  cat((crayon::bold("~Trendy results~\n")))
  cat("\nSearch Terms: ")
  cat(paste(get_interest(x) %>%
              pull(keyword) %>%
              unique(),
            sep = " "), sep = ", ")
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


