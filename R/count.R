#' @title Count observations by group
#' @description Mimics dplyr::count using base R and rlang
#' @param x data.frame
#' @param ... variables to group by
#' @param wt numeric, weights to count by, Default: NULL
#' @param sort boolean, if TRUE will sort output in descending order of n, default = FALSE
#' @return data.frame
#' @examples
#' airquality%>%
#' b_count(Month,Temp)%>%
#' head()
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname b_count
#' @export
#' @author Jonathan Sidi
b_count <- function(x,..., wt = NULL, sort = FALSE){
  UseMethod("b_count")
}

#' @rdname b_count
#' @importFrom rlang quos quo_squash
#' @export
b_count.default <- function(x,..., wt = NULL, sort = FALSE){

  EXPRS <- lapply(rlang::quos(...),function(x) rlang::quo_squash(x))

  RET <- as.data.frame(with(x,do.call(table,EXPRS)))

  names(RET)[ncol(RET)] <- 'n'

  RET

}

#' @rdname b_count
#' @export
b_count.split_df <- function(x,..., wt = NULL, sort = FALSE){

  bindr(split(x), b_count, x, ...)

}
