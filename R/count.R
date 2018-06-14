#' @title Count observations by group
#' @description Mimics dplyr::count using base R and rlang
#' @param x data.frame
#' @param ... variables to group by
#' @param wt numeric, weights to count by, Default: NULL
#' @param sort boolean, if TRUE will sort output in descending order of n, default = FALSE
#' @return data.frame
#' @examples
#' airquality%>%
#' count(Month,Temp)%>%
#' head()
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname count
#' @export
#' @author Jonathan Sidi
count <- function(x,..., wt = NULL, sort = FALSE){
  UseMethod("count")
}

#' @rdname count
#' @importFrom rlang quos quo_expr
#' @export
count.default <- function(x,..., wt = NULL, sort = FALSE){

  EXPRS <- lapply(rlang::quos(...),function(x) rlang::quo_expr(x))

  RET <- as.data.frame(with(x,do.call(table,EXPRS)))

  names(RET)[ncol(RET)] <- 'n'

  RET

}

#' @rdname count
#' @export
count.split_df <- function(x,..., wt = NULL, sort = FALSE){

  bindr(split(x), count, x, ...)

}
