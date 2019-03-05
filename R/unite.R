#' @title Unite multiple columns into one.
#' @description Mimics tidyr::unite using base R and rlang
#' @param data data.frame
#' @param col character, name of the new column
#' @param \dots columns to combine
#' @param sep character, separator to use between values, Default: '_'
#' @param remove boolean, if TRUE remove input columns from output object, Default: TRUE
#' @details the main difference between this lite version and the tidyr version is that the
#' new column is attached to the end of the data.frame and not before the index of the first column
#' that is to be united. Since this is mainly aesthetic it was not transfered over.
#' @return data.frame
#' @examples
#'
#' b_unite(airquality, col = "month_day", columns = c(Month,Day))%>%
#' head
#'
#' b_unite(airquality, col = "temp_month_day", columns = c(Temp:Day))%>%
#' head
#'
#' b_unite(airquality, col = "month_day", columns = c("Month","Day"))%>%
#' head
#'
#'
#' @rdname b_unite
#' @author Jonathan Sidi
#' @export

b_unite <- function(data,
                  col,
                  ...,
                  sep = '_',
                  remove = TRUE){

  cols_idx <- names(b_select(data,...))

  data[col] <- apply(X = b_select(data,...),
                    MARGIN = 1,
                    FUN = paste0,
                    collapse = sep)

  if(remove)
    data[cols_idx] <- NULL

  return(data)

}
