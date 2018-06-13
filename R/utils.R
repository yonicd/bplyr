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

bindr <- function(split_df, fn, .data, ...){

  split_df <- split_df[sapply(split_df,function(x) nrow(x)>0)]

  ret <- lapply(split_df,fn,...)

  ret_rbind <- do.call('rbind',ret)

  #ret_groups <- as.data.frame(do.call(rbind,strsplit(rownames(ret_rbind),'[.]')),stringsAsFactors = FALSE)

  groups <- unique(splitter(.data))

  #names(ret_groups) <- names(groups)

  #ret_groups <- sapply(ret_groups,utils::type.convert)

  ret_cbind <- cbind(groups,ret_rbind)

  row.names(ret_cbind) <- NULL

  regroup(ret_cbind,.data)
}

strip_class <- function(data){
  class(data) <- class(data)[-1]
  data
}
