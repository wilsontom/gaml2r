#' Open GAML File
#'
#' Open and extract data from a GAML file containing High Performance Liquid Chromatography (HPLC) Refractive Index (RI) data
#'
#' @param gaml_file a `.gaml` file
#' @param output a character string of either `list` (default) of `tbl_df`
#' @param include_injection_info; logical (default = `FALSE`). If `TRUE` sample injection information is also included
#' @return if `output = list` then a nested list is returned. If `output = tbl_df` then all data is returned in a single long format `tbl_df`
#'
#' @export

openFile <- function(gaml_file, output = 'list', include_injection_info = FALSE)
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

  if (isTRUE(include_injection_info)) {
    injection_info <- purrr::map(exps, extract_meta)
  }


  if (output == 'list' & isTRUE(include_injection_info)) {
    for (i in seq_along(parsed_data)) {
      parsed_data[[i]] <- c(parsed_data[[i]], injection_info[i])
    }
    return(parsed_data)
  }

  if (output == 'list' & include_injection_info == FALSE) {
    return(parsed_data)
  }


  if (output == 'tbl_df' & include_injection_info == FALSE) {
    long_form_data <-
      purrr::map(parsed_data, tibble::as_tibble) %>% dplyr::bind_rows()
    return(long_form_data)
  }


  if (output == 'tbl_df' & isTRUE(include_injection_info)) {
    long_form_data <-
      purrr::map(parsed_data, tibble::as_tibble) %>% dplyr::bind_rows()

    injection_tbl_df <- purrr::map(injection_info, ~ {
      tidyr::pivot_wider(., names_from = 'name', values_from = 'value')
    }) %>% dplyr::bind_rows() %>% dplyr::left_join(long_form_data, ., by = 'sample_name')

    return(injection_tbl_df)

  }

}
