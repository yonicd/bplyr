#' @importFrom rlang quo_squash
splitter <- function(.data){

  subset(strip_class(.data),
         select = unlist(lapply(
           attr(.data,'splitby'),
           function(x){eval(rlang::quo_squash(x))})
         ))
}


split.split_df <- function(x,f = splitter){
  split(strip_class(x),f(x))
}
