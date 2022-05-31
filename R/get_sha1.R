#' Extract the SHA1 Integrity Algorithm
#'
#' @param gaml_file a `.gaml` file
#' @return an alpha-numeric string of the SHA1 integrity algorithm for the GAML file
#'
#' @export

get_sha1 <- function(gaml_file)
{
  if (tools::file_ext(gaml_file) != 'gaml')
  {
    message(crayon::bold(
      crayon::yellow(cli::symbol$warning, "input file must be .gaml")
    ))
    return(invisible(NULL))

  }

  xmlDoc <- xml2::read_xml(gaml_file)

  integrity_algo <- xml2::xml_find_all(xmlDoc, "integrity") %>%
    xml2::xml_text()

  return(integrity_algo)
}
