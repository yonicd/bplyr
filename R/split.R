#' @importFrom rlang quo_expr
splitter <- function(.data){

  subset(strip_class(.data),
         select = unlist(lapply(
           attr(.data,'splitby'),
           function(x){eval(rlang::quo_expr(x))})
         ))
}


split.split_df <- function(x,f = splitter){
  split(strip_class(x),f(x))
}
