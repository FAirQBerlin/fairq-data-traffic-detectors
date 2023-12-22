test_that("check_unique_key() works with one key column", {
  input_df <- data.frame(a = c(1, 1, 2),
                         b = c(1, 2, 3))
  expect_error(check_unique_key(input_df, "a"))
  expect_error(check_unique_key(input_df, "b"), NA)
})

test_that("check_unique_key() works with two key columns", {
  input_df <- data.frame(a = c(1, 1, 2, 2),
                         b = c(3, 4, 4, 4),
                         c = c(1, 1, 2, 3))
  expect_error(check_unique_key(input_df, c("a", "b")))
  expect_error(check_unique_key(input_df, c("b", "c")), NA)
})
