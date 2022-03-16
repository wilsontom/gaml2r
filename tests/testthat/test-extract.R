test_that("extract", {

  test_file <-
    system.file('extdata/example_data_ri.gaml', package = 'gamlr')

  open_file <- openFile(test_file)

  expect_true(class(open_file) == 'list')

  length_check <- sapply(open_file, length)
  expect_true(all(length_check == 4))

  expect_true(is.character(open_file[[1]]$samplename))

  expect_true(is.vector(open_file[[1]]$time))
  expect_true(is.numeric(open_file[[1]]$time))

  expect_true(is.vector(open_file[[1]]$value))
  expect_true(is.numeric(open_file[[1]]$value))


})
