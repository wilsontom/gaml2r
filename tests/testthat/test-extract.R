test_that("extract", {

  test_file <-
    system.file('extdata/example_data_ri.gaml', package = 'gaml2r')

  # no injection info
  open_file <- openFile(test_file)

  expect_true(class(open_file) == 'list')

  length_check <- sapply(open_file, length)
  expect_true(all(length_check == 4))

  expect_true(is.character(open_file[[1]]$sample_name))

  expect_true(is.vector(open_file[[1]]$time))
  expect_true(is.numeric(open_file[[1]]$time))

  expect_true(is.vector(open_file[[1]]$value))
  expect_true(is.numeric(open_file[[1]]$value))


  # with injection info

  open_file_winfo <- openFile(test_file, include_injection_info = TRUE)

  expect_true(class(open_file_winfo) == 'list')

  length_check <- sapply(open_file_winfo, length)
  expect_true(all(length_check == 5))

  expect_true(is.character(open_file_winfo[[1]]$sample_name))

  expect_true(is.vector(open_file_winfo[[1]]$time))
  expect_true(is.numeric(open_file_winfo[[1]]$time))

  expect_true(is.vector(open_file_winfo[[1]]$value))
  expect_true(is.numeric(open_file_winfo[[1]]$value))


  expect_true(tibble::is_tibble(open_file_winfo[[1]][[5]]))
  expect_true(ncol(open_file_winfo[[1]][[5]]) == 2)


  expect_true(is.character(get_sha1(test_file)))
  expect_true(tibble::is_tibble(get_parameters(test_file)))



})
