#' Extract the GAML Conversion Parameters
#'
#' @param gaml_file a `.gaml` file
#' @return a `tbl_df` of GAML conversion parameters
#'
#' @export

get_parameters <- function(gaml_file)
{
  if (tools::file_ext(gaml_file) != 'gaml')
  {
    message(crayon::bold(
      crayon::yellow(cli::symbol$warning, "input file must be .gaml")
    ))
    return(invisible(NULL))

  }

  xmlDoc <- xml2::read_xml(gaml_file)

  xmlParams <-
    param_extract <- xml2::xml_find_all(xmlDoc, "parameter") %>%
    xml2::xml_text()

  params_tbldf <- tibble::tibble(
    'GAML Generation' = xmlParams[1],
    'Version' = xmlParams[2],
    'Convertor' = xmlParams[3]
  )

 return(params_tbldf)

}
