#' @title base unite
#' @description base unite mimics basic functionality of tidyr::unite
#' @param data data.frame
#' @param col character, name of the new column
#' @param columns column names or indicies or regex of them to gather,
#'  Default: NULL
#' @param regex boolean, indicates of columns is to be treated as a
#' regular expression, Default: FALSE
#' @param \dots parameters to pass to grep
#' @param sep character, separator to use between values, Default: '_'
#' @param remove boolean, if TRUE remove input columns from output object, Default: TRUE
#' @details the main difference between this lite version and the tidyr version is that the
#' new column is attached to the end of the data.frame and not before the index of the first column
#' that is to be united. Since this is mainly aesthetic it was not transfered over.
#' @return data.frame
#' @examples
#'
#' unite(mtcars, col = "vs_am", columns = c("vs","am"))
#'
#' unite(mtcars, col = "disp_drat", columns = '^d', regex = TRUE)
#'
#' @rdname unite
#' @author Jonathan Sidi
#' @export

unite <- function(data,
                  col,
                  columns = NULL,
                  regex = FALSE,
                  sep = '_',
                  remove = TRUE,
                  ...){

  class_in <- class(data)

  cols_idx   <- find_idx(data, columns, regex = regex, ...)

  ret <- data

  ret[col] <- apply(data[cols_idx],1,paste0,collapse = sep)

  if(remove)
    ret[cols_idx] <- NULL

  class(ret) <- class_in

  ret

}
