#' @title Arrange rows by variables
#' @description Mimics dplyr::arrange using base R and rlang
#' @param .data data.frame
#' @param ... Comma separated list of unquoted variable names, use `-` for
#' descending order.
#' @return data.frame
#' @examples
#' airquality%>%
#' b_arrange(-Month,Temp)%>%
#' head()
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname b_arrange
#' @export
#' @author Jonathan Sidi
b_arrange <- function(.data,...){
  UseMethod("b_arrange")
}

#' @rdname b_arrange
#' @export
#' @importFrom rlang quos quo_expr
b_arrange.default <- function(.data,...){

  EXPRS <- lapply(rlang::quos(...),function(x) rlang::quo_expr(x))

  .data[with(.data,do.call(order,EXPRS)),]

}

#' @rdname b_arrange
#' @export
b_arrange.split_df <- function(.data,...){

  bindr(split(.data), b_arrange, .data, ...)

}
