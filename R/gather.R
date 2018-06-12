#' @title base gather
#' @description base gather mimics basic functionality of tidyr::gather
#' @param data data.frame
#' @param key character, name of new key column, Default: 'key'
#' @param value character, name of new value column, Default: 'value'
#' @param columns column names or indicies or regex of them to gather,
#'  Default: NULL
#' @param regex boolean, indicates of columns is to be treated as a
#' regular expression, Default: FALSE
#' @param \dots parameters to pass to grep
#' @param na.rm boolean, apply na.omit to value column, Default: FALSE
#' @param convert boolean, apply type.convert to key column, Default: FALSE
#' @return data.frame
#' @examples
#'
#' mini_iris <- iris[c(1, 51, 101), ]
#'
#' # gather Sepal.Length, Sepal.Width, Petal.Length, Petal.Width
#'
#' gather(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'))
#'
#' gather(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = 1:4)
#'
#' gather(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = -5)
#'
#' gather(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = '^(Sepal|Petal)',regex = TRUE)
#'
#' @seealso
#'  \code{\link[utils]{type.convert}}
#' @rdname gather
#' @author Jonathan Sidi
#' @export
#' @importFrom utils type.convert
#' @importFrom stats na.omit
gather <- function(data,
                   key = 'key',
                   value = 'value',
                   columns = NULL,
                   regex = FALSE,
                   ...,
                   na.rm = FALSE,
                   convert = FALSE) {

  class_in <- class(data)

  cols_idx   <- find_idx(data, columns, regex = regex, ...)

  y <- data[-cols_idx]

  if(regex)
    columns <- names(data)[cols_idx]

  x <- c(data[columns])

  l <- lapply(names(x),function(nm,y){
    data.frame(y,NAME__ = nm,VALUE__ = x[[nm]],stringsAsFactors = FALSE)
  },y=y)

  ret <- do.call('rbind',l)

  if(na.rm)
    ret <- na.omit(ret)

  if(convert){

    class_key <- all(grepl(pattern = '^[1-9]\\d*(\\.\\d+)?$',ret$NAME__))

    if(class_key){
      ret$NAME__ <- utils::type.convert(ret$NAME__,as.is = TRUE)
    }else{
      ret$NAME__ <- utils::type.convert(as.character(ret$NAME__),as.is = TRUE)
    }

  }

  names(ret)[names(ret)=='NAME__'] <- key
  names(ret)[names(ret)=='VALUE__'] <- value

  class(ret) <- class_in

  ret
}
