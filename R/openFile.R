#' Open GAML File
#'
#' Open and extract data from a GAML file containing High Performance Liquid Chromatography (HPLC) Refractive Index (RI) data
#'
#' @param gaml_file a `.gaml` file
#' @return a nested list of `sampleName`, `time` and `RI` for each sample in the `GAML` file.
#'
#' @export

openFile <- function(gaml_file)
{
  xmlDoc <- xml2::read_xml(gaml_file)

  exps <- xml2::xml_find_all(xmlDoc, "experiment")

  parsed_data <- purrr::map(exps, extract_sample)

  return(parsed_data)

}
