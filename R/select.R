#' @title Select/rename variables by name
#' @description Mimics dplyr::select using base R and rlang
#' @param .data data.frame
#' @param ... unquoted variable names or character names
#' @return data.frame
#' @examples
#'
#' airquality%>%
#' b_select(c(Day,Temp))%>%
#' head()
#'
#' airquality%>%
#' b_select(c('Day','Temp'))%>%
#' head()
#'
#' airquality%>%
#' b_select(-c(Day,Temp))%>%
#' head()
#'
#' @seealso
#'  \code{\link[rlang]{quotation}},\code{\link[rlang]{quo_squash}}
#' @rdname b_select
#' @export
#' @author Jonathan Sidi
b_select <- function(.data,...){
  UseMethod("b_select")
}

#' @importFrom rlang quos quo_squash
#' @rdname b_select
#' @export
b_select.default <- function(.data,...){

  subset(.data,
         select = unlist(lapply(
           rlang::quos(...),
           function(x){eval(rlang::quo_squash(x))})
         ))
}

#' @rdname b_select
#' @export
b_select.split_df <- function(.data,...){

  bindr(split(.data), b_select, .data, ...)

}
