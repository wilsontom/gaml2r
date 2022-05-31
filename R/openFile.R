#' Open GAML File
#'
#' Open and extract data from a GAML file containing High Performance Liquid Chromatography (HPLC) Refractive Index (RI) data
#'
#' @param gaml_file a `.gaml` file
#' @param output a character string of either `list` (default) of `tbl_df`
#' @return if `output = list` then a nested list is returned. If `output = tbl_df` then all data is returned in a single long format `tbl_df`
#'
#' @export

openFile <- function(gaml_file, output = 'list')
{
  if (tools::file_ext(gaml_file) != 'gaml')
  {
    message(crayon::bold(
      crayon::yellow(cli::symbol$warning, "input file must be .gaml")
    ))
    return(invisible(NULL))

  }

  xmlDoc <- xml2::read_xml(gaml_file)

  exps <- xml2::xml_find_all(xmlDoc, "experiment")

  parsed_data <- purrr::map(exps, extract_sample)

  if (output == 'list') {
    return(parsed_data)
  }

  if (output == 'tbl_df') {
    long_form_data <-
      purrr::map(parsed_data, tibble::as_tibble) %>% dplyr::bind_rows()
    return(long_form_data)
  }
}
