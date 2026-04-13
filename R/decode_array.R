#' Decode Base 64 Arrays
#'
#' @param x a `base64` encoded character vector
#' @param size a numeric value of byte size to use (default is `8`)
#' @return a decoded vector
#' @keywords internal
#' @export

decode_array <- function(x, size = 8)
{
  xdec <- base64enc::base64decode(x)
  raw_x <- as.raw(xdec)

  raw_x2 <- memDecompress(from = raw_x, 'none')

  bins_x <-
    readBin(
      raw_x2,
      what = "double",
      n = length(raw_x2) / size,
      size = size,
      endian = .Platform$endian
    )

  return(bins_x)


}
