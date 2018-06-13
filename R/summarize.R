#' @title Reduces multiple values down to a single value
#' @description Mimics dplyr::summarize using base R and rlang
#' @param .data data.frame
#' @param ... Name-value pairs of summary functions
#' @return data.frame
#' @examples
#' airquality%>%
#'   noplyr::group_by(Month)%>%
#'   noplyr::summarize(m = mean(Temp),m1 = max(Temp))
#'
#' airquality%>%
#'   noplyr::group_by(Month,Day)%>%
#'   noplyr::summarize(m = mean(Temp),m1 = max(Temp))
#'
#' airquality%>%
#'   noplyr::mutate(Month = factor(Month))%>%
#'   noplyr::group_by(Month)%>%
#'   noplyr::summarize(m = mean(Temp),m1 = max(Temp))
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname summarize
#' @export
#' @author Jonathan Sidi
#' @importFrom rlang quos
summarize <- function(.data,...){
  UseMethod("summarize")
}

#' @rdname summarize
#' @export
summarize.default <- function(.data,...){

  FNS <- lapply(rlang::quos(...),quo_expr)

  EVALS <- lapply(FNS,function(x){
    with(.data,eval(x))
  })

  data.frame(EVALS,stringsAsFactors = FALSE)

}

#' @rdname summarize
#' @export
summarize.split_df <- function(.data,...){

  bindr(split(.data), summarize, .data, ...)

}
