#' @title Group by one or more variables
#' @description Mimics dplyr::group_by using base R and rlang
#' @param .data data.frame
#' @param ... Variables to group by
#' @param add When add = FALSE, the default, group_by() will override existing groups.
#'  To add to the existing groups, use add = TRUE., Default: FALSE
#' @return data.frame
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


#' @title Remove grouping from data.frame
#' @description Mimics dplyr::ungroup using base R
#' @param .data data.frame
#' @return data.frame
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
