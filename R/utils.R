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
