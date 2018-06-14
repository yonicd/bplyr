#' @title Count observations by group
#' @description Mimics dplyr::count using base R and rlang
#' @param x data.frame
#' @param ... variables to group by
#' @param wt numeric, weights to count by, Default: NULL
#' @param sort boolean, if TRUE will sort output in descending order of n, default = FALSE
#' @return data.frame
#' @examples
#' airquality%>%
#' rename(tmp = Temp,day = Day)%>%
#' head()
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname rename
#' @export
#' @author Jonathan Sidi
#' @importFrom rlang quos quo_expr
rename <- function(.data,...){

  FNS <- lapply(rlang::quos(...),rlang::quo_expr)

  EXPRS <- lapply(names(FNS),function(x){
    c(x,deparse(FNS[[x]]))
  })

  NAMES <- do.call(rbind,EXPRS)

  for(i in 1:nrow(NAMES)){
    names(.data)[match(NAMES[i,2],names(.data))] <- NAMES[i,1]
  }

  .data


}
