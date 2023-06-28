#' Extract Injection Meta Data
#'
#' @param x a `xml2` nodeset for `experiment` blocks
#' @return a `tbl_df` of injection attributes
#'
#' @keywords internal

extract_meta <- function(x)
{
  xnodeset <- xml2::xml_children(x)

  attr_tbl <-
    xml2::xml_attrs(xnodeset) %>% dplyr::bind_rows() %>% dplyr::mutate(n = seq(from = 1, to = nrow(.)))

  injection_attr <-
    attr_tbl %>% dplyr::filter(group == 'Injection') %>%
    dplyr::filter(
      name %in% c(
        'type',
        'position',
        'inject_volume',
        'weight',
        'dilution_factor',
        'amount',
        'replicate',
        'comment'
      )
    ) %>%
    dplyr::select(name, alias, n)


  meta_ext <-
    xml2::xml_contents(xnodeset)[injection_attr$n] %>% xml2::xml_text()

  meta_table <-
    tibble::tibble(n = injection_attr$n, value = meta_ext)

  sample_name <-
    tibble::tibble(name = 'sample_name', value = xml2::xml_attrs(x)[['name']])

  meta_info_join <-
    injection_attr %>% dplyr::left_join(., meta_table, by = 'n') %>%
    dplyr::select(name, value) %>%
    dplyr::bind_rows(sample_name, .)


  return(meta_info_join)

}
