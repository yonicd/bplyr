#' @title Return rows with matching conditions
#' @description Mimics dplyr::filter using base R and rlang
#' @param .data data.frame
#' @param ... Logical predicates defined in terms of the variables in .data
#' @return data.frame
#' @examples
#' airquality%>%
#' filter(Temp > 80)%>%
#' head()
#'
#' @seealso
#'  \code{\link[rlang]{quo_expr}},\code{\link[rlang]{quotation}}
#' @rdname filter
#' @export
#' @author Jonathan Sidi
filter <- function(.data,...){
  UseMethod("filter")
}

#' @rdname filter
#' @export
#' @importFrom rlang quo_expr quo
filter.default <- function(.data,...){
  subset(.data,{
    eval(rlang::quo_expr(rlang::quo(...)))
  })
}

#' @rdname filter
#' @export
filter.split_df <- function(.data,...){

  bindr(split(.data), filter, .data, ...)

}
