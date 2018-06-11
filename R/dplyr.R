#' @title Return rows with matching conditions
#' @description Mimics dplyr::filter using base R and rlang
#' @param .data data.frame
#' @param ... Logical predicates defined in terms of the variables in .data
#' @return data.frame
#' @examples
#' airquality%>%
#' filter(Temp > 80)%>%
#' head()
#'
#' @seealso
#'  \code{\link[rlang]{quo_expr}},\code{\link[rlang]{quotation}}
#' @rdname filter
#' @export
#' @author Jonathan Sidi
#' @importFrom rlang quo_expr quo
filter <- function(.data,...){
  subset(.data,{
    eval(rlang::quo_expr(rlang::quo(...)))
  })
}

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
#' @importFrom rlang quos quo_expr
select <- function(.data,...){
  subset(.data,
         select = unlist(lapply(
           rlang::quos(...),
           function(x){eval(rlang::quo_expr(x))})
         ))
}

#' @title Add new variables
#' @description Mimics dplyr::mutate using base R and rlang
#' @param .data data.frame
#' @param ... Name-value pairs of expressions
#' @return data.frame
#' @examples
#' airquality%>%
#' mutate(
#'     lOzone = log(Ozone),
#'     Month  = factor(month.abb[Month]),
#'     cTemp  = round((Temp - 32) * 5/9, 1),
#'     S.cT   = Solar.R / cTemp
#' )%>%
#' head()
#' @seealso
#'  \code{\link[rlang]{quotation}}
#' @rdname mutate
#' @export
#' @author Jonathan Sidi
#' @importFrom rlang quos
mutate <- function(.data,...){

  FNS <- lapply(rlang::quos(...),quo_expr)

  EXPRS <- lapply(names(FNS),function(x){
    sprintf('%s <- %s',x,deparse(FNS[[x]]))
  })

  within(.data,eval(parse(text = paste0(unlist(EXPRS),collapse = '\n'))))

}

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
#' @importFrom rlang quos
arrange <- function(.data,...){

  EXPRS <- lapply(rlang::quos(...),function(x) quo_expr(x))

  .data[with(.data,do.call(order,EXPRS)),]

}
