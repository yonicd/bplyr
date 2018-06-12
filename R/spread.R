#' @title base spread
#' @description base spread mimics basic functionality of tidyr::spread
#' @param data data.frame
#' @param key column which will become the new columns
#' @param value column name which will populate new columns
#' @param convert type.convert will run on each result column if TRUE, Default: FALSE
#' @return data.frame
#' @examples
#' stocks <- data.frame(
#' time = as.Date('2009-01-01') + 0:9,
#' X = rnorm(10, 0, 1),
#' Y = rnorm(10, 0, 2),
#' Z = rnorm(10, 0, 4)
#' )
#' stocksm <- gather(stocks,'stock', 'price', -1)
#' spread(stocksm, 'stock', 'price')

#' # spread and gather are complements
#' df <- data.frame(x = c("a", "b"), y = c(3, 4), z = c(5, 6))
#' sdf <- spread(df, 'x', 'y')
#' gather(sdf, 'x', 'y', -1, na.rm = TRUE)
#'
#' # Use 'convert = TRUE' to produce variables of mixed type
#' df <- data.frame(row = rep(c(1, 51), each = 3),
#'                  var = c("Sepal.Length", "Species", "Species_num"),
#'                  value = c(5.1, "setosa", 1, 7.0, "versicolor", 2))
#'
#' str(spread(df, 'var', 'value'))
#' str(spread(df, 'var', 'value',convert = TRUE))
#' @rdname spread
#' @author Jonathan Sidi
#' @export
#' @importFrom utils type.convert
spread <- function(data,
                   key,
                   value,
                   convert = FALSE) {

  key_idx   <- find_idx(data,key)
  value_idx <- find_idx(data,value)

  if(length(key_idx)>1){
    data[key_idx[1]] <- apply(data[,key_idx],1,paste0,collapse = '_')
    data[,key_idx[-1]] <- NULL
    key_idx <- key_idx[1]
  }

  rhs <- data[, key_idx]

  s_ <- split(data,rhs)

  l <- lapply(s_,function(x,key_idx,value_idx){

    names(x)[value_idx] <- as.character(unique(x[[key_idx]]))

    x[,-key_idx]
  },key_idx = key_idx, value_idx = value_idx)

  ret <- l[[1]]

  for(i in 2:length(l))
    ret <- merge(ret,l[[i]],all = TRUE)

  if(convert){

    class_idx <- sapply(ret,function(y) all(grepl(pattern = '^[1-9]\\d*(\\.\\d+)?$',y)))

    for(i in which(class_idx))
      ret[[i]] <- as.numeric(ret[[i]],as.is = TRUE)


    for(i in which(!class_idx))
      ret[[i]] <- utils::type.convert(as.character(ret[[i]]),as.is = TRUE)
  }

  ret
}
