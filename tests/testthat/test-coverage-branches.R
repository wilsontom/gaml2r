test_that("openFile covers tbl_df output with injection info", {
  test_file <- system.file("extdata/example_data_ri.gaml", package = "gaml2r")

  open_file_df <- openFile(
    test_file,
    output = "tbl_df",
    include_injection_info = TRUE
  )

  expect_true(tibble::is_tibble(open_file_df))
  expect_equal(nrow(open_file_df), 3025)
  expect_true(all(c("sample_name", "datestamp", "time", "value", "type") %in% names(open_file_df)))
  expect_false(anyNA(open_file_df$type))
})

test_that("public helpers reject non-gaml inputs", {
  expect_message(expect_null(openFile("bad.txt")))
  expect_message(expect_null(get_parameters("bad.txt")))
  expect_message(expect_null(get_sha1("bad.txt")))
})

test_that("extract_sample parses the first experiment block", {
  test_file <- system.file("extdata/example_data_ri.gaml", package = "gaml2r")
  xml_doc <- xml2::read_xml(test_file)
  experiment <- xml2::xml_find_first(xml_doc, "//experiment")

  sample <- gaml2r:::extract_sample(experiment)

  expect_named(sample, c("sample_name", "datestamp", "time", "value"))
  expect_type(sample$sample_name, "character")
  expect_type(sample$datestamp, "character")
  expect_type(sample$time, "double")
  expect_type(sample$value, "double")
  expect_length(sample$time, 121)
  expect_length(sample$value, 121)
})

test_that("extract_meta returns injection metadata for the first experiment", {
  test_file <- system.file("extdata/example_data_ri.gaml", package = "gaml2r")
  xml_doc <- xml2::read_xml(test_file)
  experiment <- xml2::xml_find_first(xml_doc, "//experiment")

  meta <- gaml2r:::extract_meta(experiment)

  expect_true(tibble::is_tibble(meta))
  expect_named(meta, c("name", "value"))
  expect_true("sample_name" %in% meta$name)
  expect_true("type" %in% meta$name)
  expect_equal(meta$value[meta$name == "sample_name"], "Ctrl01")
})

test_that("decode_array round-trips encoded doubles", {
  vals <- c(1, 2.5, 7)
  raw <- writeBin(vals, raw(), size = 8, endian = .Platform$endian)
  enc <- base64enc::base64encode(raw)

  expect_equal(decode_array(enc), vals)
})

test_that("parameter and sha helpers return expected values", {
  test_file <- system.file("extdata/example_data_ri.gaml", package = "gaml2r")

  params <- get_parameters(test_file)
  sha1 <- get_sha1(test_file)

  expect_true(tibble::is_tibble(params))
  expect_named(params, c("GAML Generation", "Version", "Convertor"))
  expect_equal(params[["GAML Generation"]], "GAMLIO")
  expect_equal(params[["Version"]], "9.7.0.1")
  expect_equal(params[["Convertor"]], "Chromeleon")
  expect_equal(sha1, "141f6452bb6ea219e60121ba57d6f786c0819e1e")
})
