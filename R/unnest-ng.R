
#' Unnest a list column
#'
#' If you have a list column and you would like to preserve the names of the column then this is the way to go
#'
#' This function is essentially a wrapper for `tidyr::unnest`, except that it has the option to preserve the names
#' of lists in a separate column
#'
#' @param data A data.frame
#' @param col Column to unnest
#' @param keep_names Should we keep the names of the list column? If not null, the value will be used as the name of the new column
#' @param keep_empty Should we keep rows with length 0? In `tidyr::unnest()` this parameter is `FALSE` by default which is inconvenient
#' @param ... Other parameters to pass to `tidyr::unnest()`
#'
#' @return A data.frame with the unnested column
#' @export
#'
#' @seealso `tidyr::unnest()`
#'
unnest_names <- function(data, col, keep_names = NULL, keep_empty = TRUE, ...) {

  col <- dplyr::enquo(col)

  if(is.null(keep_names)) {
    tidyr::unnest(data, cols = c(!!col), keep_empty = keep_empty, ...)
  } else {
    colNames <- dplyr::sym(keep_names)
    data <- dplyr::mutate(data, !!colNames := lapply(!!col, names))

    tidyr::unnest(data, cols = c(!!col, !!colNames), keep_empty = keep_empty, ...)
  }
}
