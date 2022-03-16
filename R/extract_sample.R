#' Extract and Parse Sample Experiment Blocks
#'
#' @param x a `xml2` nodeset for `experiment` blocks
#' @return a list of four elements
#'   * `samplename` a character string of the sample name
#'   * `samplename` a character timestamp
#'   * `time` a numeric vector of retention time
#'   * `value` a numeric vector of detector response
#'
#' @export
#' @importFrom magrittr %>%

extract_sample <- function(x)
{
  xnodeset <- xml2::xml_children(x)


  sample_name <- xml2::xml_attrs(x)[['name']]

  collect_date <- xml2::xml_children(x)[[1]] %>% xml2::xml_text()

  content_values <-
    xnodeset %>% xml2::xml_children() %>% xml2::xml_contents()

  chrom_xml <- content_values[[4]] %>% xml2::xml_children()

  rt_tmp <- content_values[[3]] %>% xml2::xml_text()

  rt_raw <- stringr::str_remove(rt_tmp, '\n       ') %>% trimws()

abs_tmp <-
    chrom_xml[[1]] %>% xml2::xml_contents() %>% xml2::xml_text()

  abs_raw <- stringr::str_remove(abs_tmp, '\n       ') %>% trimws()

  rt <- decode_array(rt_raw)
  abs <- decode_array(abs_raw)

  return(list(
    samplename = sample_name,
    datestamp = collect_date,
    time = rt,
    value = abs
  ))

}
