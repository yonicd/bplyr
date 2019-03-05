#' @title Group by one or more variables
#' @description Mimics dplyr::group_by using base R and rlang
#' @param .data data.frame
#' @param ... Variables to group by
#' @param add When add = FALSE, the default, group_by() will override existing groups.
#'  To add to the existing groups, use add = TRUE., Default: FALSE
#' @return data.frame
#' @rdname b_group_by
#' @export

b_group_by <- function(.data,..., add = FALSE){
  UseMethod("b_group_by")
}

#' @rdname b_group_by
#' @export
#' @importFrom rlang quos
b_group_by.data.frame <- function(.data,..., add = FALSE){
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
#' @rdname b_ungroup
#' @export

b_ungroup <- function(.data){
  UseMethod("b_ungroup")
}

#' @rdname b_ungroup
#' @export
b_ungroup.default <- function(.data){
  .data
}

#' @rdname b_ungroup
#' @export
b_ungroup.split_df <- function(.data){

  attr(.data,'splitby') <- NULL

  class(.data) <- class(.data)[-1]

  .data

}
