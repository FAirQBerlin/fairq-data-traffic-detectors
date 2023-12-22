test_that("number_to_weekday yields correct results", {
  res <- number_to_weekday(c(0, 1, 7, 8))
  
  # Test must work in German or English;
  # we just want to check that the correct day is returned
  expect_true(res[1] %in% c("So", "Sun"))
  expect_true(res[2] %in% c("Mo", "Mon"))
  expect_true(res[3] %in% c("So", "Sun"))
  expect_true(res[4] %in% c("Mo", "Mon"))
})

test_that("add_date_year_month can deal with months with or without leading 0",
          {
            input_df <- data.frame(Jahr = c(2020, 2021, 2022),
                                   Monat = c(1, 05, 12))
            expected_df <- data.frame(
              Jahr = c(2020, 2021, 2022),
              Monat = c("01", "05", "12"),
              Datum = as.Date(c(
                "2020-01-01", "2021-05-01", "2022-12-01"
              ))
            )
            expect_equal(add_date_year_month(input_df), expected_df)
          })
