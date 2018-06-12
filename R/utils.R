#' @title re-export magrittr pipe operators
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL

find_idx <- function(data, obj = NULL, regex = FALSE,...){

  if(inherits(obj,'NULL'))
    return(1:ncol(data))


  if(inherits(obj,'character')){
    if(regex){
      return(grep(obj,names(data),...))
    }else{
      return(which(names(data)%in%obj))
    }
  }

  if(inherits(obj,c('numeric','integer'))){
    if(obj<0){

      (1:ncol(data))[obj]
    }else{
      obj
    }
  }

}

rbind_fn <- function(split_df, fn, .data, ...){

  ret <- lapply(split_df,fn,...)

  ret <- do.call('rbind',ret)

  row.names(ret) <- NULL

  regroup(ret,.data)
}

strip_class <- function(data){
  class(data) <- class(data)[-1]
  data
}

#' @importFrom rlang quo_expr
splitter <- function(.data){

  subset(strip_class(.data),
         select = unlist(lapply(
           attr(.data,'splitby'),
           function(x){eval(rlang::quo_expr(x))})
         ))
}
