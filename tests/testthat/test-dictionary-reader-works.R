punc_file_loc <- system.file("extdata",
                             "punctuation.json",
                             package = "stenor",
                             mustWork = T)

out <- read_plover_dict(punc_file_loc)

test_that("result is tibble", {

  expect_true(tibble::is_tibble(out))
})

test_that("result has correct number of rows", {
  expect_equal(nrow(out), 31L)
})

test_that("result has correct number of columns", {
  expect_equal(ncol(out), 2)
})

test_that("result has correctly named columns", {
  expect_equal(colnames(out), c("result", "strokes"))
})
