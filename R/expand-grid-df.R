
#' Create a Data Frame from All Combinations of Variables
#'
#' Create a data.frame from all combinations of the supplied vectors, factors, or \code{data.frame}s.
#'
#' This is an extension of \link[base]{expand.grid} that also supports \code{data.frame}s.
#' Courtesy to the user \code{ytsaig} on StackOverflow \url{https://stackoverflow.com/a/21911221}
#'
#' @param ... vectors, factors, or \code{data.frame}s to combine
#'
#' @return A \code{data.frame} containing one row for each combination of input values.
#'
#' @export
#'
#' @references \url{https://stackoverflow.com/a/21911221}
#'
expand.grid.df <- function(...) {
  Reduce(function(...) merge(..., by=NULL), list(...))
}
