#' @title Select/rename variables by name
#' @description Mimics dplyr::select using base R and rlang
#' @param .data data.frame
#' @param ... unquoted variable names or character names
#' @return data.frame
#' @examples
#'
#' airquality%>%
#' select(c(Day,Temp))%>%
#' head()
#'
#' airquality%>%
#' select(c('Day','Temp'))%>%
#' head()
#'
#' airquality%>%
#' select(-c(Day,Temp))%>%
#' head()
#'
#' @seealso
#'  \code{\link[rlang]{quotation}},\code{\link[rlang]{quo_expr}}
#' @rdname select
#' @export
#' @author Jonathan Sidi
select <- function(.data,...){
  UseMethod("select")
}

#' @importFrom rlang quos quo_expr
#' @rdname select
#' @export
select.default <- function(.data,...){

  subset(.data,
         select = unlist(lapply(
           rlang::quos(...),
           function(x){eval(rlang::quo_expr(x))})
         ))
}

#' @rdname select
#' @export
select.split_df <- function(.data,...){

  split_df <- split(strip_class(.data),splitter(.data))

  rbind_fn(split_df, select, .data, ...)

}
