test_that("extract", {

  test_file <-
    system.file('extdata/example_data.gaml', package = 'gaRI')

  open_file <- openFile(test_file)

  expect_true(class(open_file) == 'list')

  length_check <- sapply(open_file, length)
  expect_true(all(length_check == 3))

  expect_true(is.character(open_file[[1]]$sampleName))

  expect_true(is.vector(open_file[[1]]$time))
  expect_true(is.numeric(open_file[[1]]$time))

  expect_true(is.vector(open_file[[1]]$RI))
  expect_true(is.numeric(open_file[[1]]$RI))


})
