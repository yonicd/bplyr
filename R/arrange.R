#' @title Arrange rows by variables
#' @description Mimics dplyr::arrange using base R and rlang
#' @param .data data.frame
#' @param ... Comma separated list of unquoted variable names, use `-` for
#' descending order.
#' @return data.frame
#' @examples
#' airquality%>%
#' arrange(-Month,Temp)%>%
#' head()
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname arrange
#' @export
#' @author Jonathan Sidi
arrange <- function(.data,...){
  UseMethod("arrange")
}

#' @rdname arrange
#' @export
#' @importFrom rlang quos quo_expr
arrange.default <- function(.data,...){

  EXPRS <- lapply(rlang::quos(...),function(x) rlang::quo_expr(x))

  .data[with(.data,do.call(order,EXPRS)),]

}

#' @rdname arrange
#' @export
arrange.split_df <- function(.data,...){

  bindr(split(.data), arrange, .data, ...)

}
