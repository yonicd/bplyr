#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param .data PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param add PARAM_DESCRIPTION, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname group_by
#' @export

group_by <- function(.data,..., add = FALSE){
  UseMethod("group_by")
}

#' @rdname group_by
#' @export
#' @importFrom rlang quos
group_by.data.frame <- function(.data,..., add = FALSE){
  attr(.data,'splitby') <- rlang::quos(...)
  class(.data) <- c('split_df',class(.data))
  .data
}

regroup <- function(new,old){

  attr(new,'splitby') <- lapply(attr(old,'splitby'),rlang::quo_set_env,parent.frame())

  class(new) <- class(old)
  new
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param .data PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ungroup
#' @export

ungroup <- function(.data){
  UseMethod("ungroup")
}

#' @rdname ungroup
#' @export
ungroup.default <- function(.data){
  .data
}

#' @rdname ungroup
#' @export
ungroup.split_df <- function(.data){

  attr(.data,'splitby') <- NULL

  class(.data) <- class(.data)[-1]

  .data

}
