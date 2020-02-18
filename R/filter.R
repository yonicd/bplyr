#' @title Return rows with matching conditions
#' @description Mimics dplyr::filter using base R and rlang
#' @param .data data.frame
#' @param ... Logical predicates defined in terms of the variables in .data
#' @return data.frame
#' @examples
#' airquality%>%
#' b_filter(Temp > 80)%>%
#' head()
#'
#' @seealso
#'  \code{\link[rlang]{quo_squash}},\code{\link[rlang]{quotation}}
#' @rdname b_filter
#' @export
#' @author Jonathan Sidi
b_filter <- function(.data,...){
  UseMethod("b_filter")
}

#' @rdname b_filter
#' @export
#' @importFrom rlang quo_squash quo
b_filter.default <- function(.data,...){
  subset(.data,{
    eval(rlang::quo_squash(rlang::quo(...)))
  })
}

#' @rdname b_filter
#' @export
b_filter.split_df <- function(.data,...){

  bindr(split(.data), b_filter, .data, ...)

}
