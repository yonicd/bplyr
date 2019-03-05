#' @title Add new variables
#' @description Mimics dplyr::mutate using base R and rlang
#' @param .data data.frame
#' @param ... Name-value pairs of expressions
#' @return data.frame
#' @examples
#' airquality%>%
#' b_mutate(
#'     lOzone = log(Ozone),
#'     Month  = factor(month.abb[Month]),
#'     cTemp  = round((Temp - 32) * 5/9, 1),
#'     S.cT   = Solar.R / cTemp
#' )%>%
#' head()
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname b_mutate
#' @export
#' @author Jonathan Sidi
b_mutate <- function(.data,...){
  UseMethod("b_mutate")
}

#' @rdname b_mutate
#' @export
#' @importFrom rlang quos quo_expr
b_mutate.default <- function(.data,...){

  FNS <- lapply(rlang::quos(...),rlang::quo_expr)

  EXPRS <- lapply(names(FNS),function(x){
    sprintf('%s <- %s',x,deparse(FNS[[x]]))
  })

  within(.data,eval(parse(text = paste0(unlist(EXPRS),collapse = '\n'))))

}

#' @rdname b_mutate
#' @export
b_mutate.split_df <- function(.data,...){

  bindr(split(.data), b_mutate, .data, ...)

}
