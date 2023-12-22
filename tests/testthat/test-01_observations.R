test_that("create_urls() creates correct URLS depending on month and year", {
  res_df <- create_urls()
  res <- res_df$url
  
  expect_s3_class(res_df, "data.frame")
  expect_type(res, "character")
  expect_equal(
    res[1],
    paste0(
      "https://mdhopendata.blob.core.windows.net/verkehrsdetektion/2015/Messquerschnitt%20",
      "(fahrtrichtungsbezogen)/mq_hr_2015_01.csv.gz"
    )
  )
  expect_equal(
    res[length(res)],
    paste0(
      "https://mdhopendata.blob.core.windows.net/verkehrsdetektion/2023/Messquerschnitte%20",
      "(fahrtrichtungsbezogen)/mq_hr_2023_08.csv.gz"
    )
  )
})

test_that("extract.observations() extracts multiple URLs and creates a list",
          {
            url_df <-
              data.frame(url = c(
                paste0(
                  "https://mdhopendata.blob.core.windows.net/verkehrsdetektion/2020/",
                  "Messquerschnitt%20(fahrtrichtungsbezogen)/mq_hr_2020_01.csv.gz"
                ),
                paste0(
                  "https://mdhopendata.blob.core.windows.net/verkehrsdetektion/2022/",
                  "Messquerschnitt%20(fahrtrichtungsbezogen)/mq_hr_2022_03.csv.gz"
                )
              ))
            
            expected_names <-
              c(
                "mq_name",
                "tag",
                "stunde",
                "qualitaet",
                "q_kfz_mq_hr",
                "v_kfz_mq_hr",
                "q_pkw_mq_hr",
                "v_pkw_mq_hr",
                "q_lkw_mq_hr",
                "v_lkw_mq_hr"
              )
            
            x <- single_source("observations", urls = url_df)
            x <- extract.observations(x)
            res <- x$dat
            expect_length(res, 2)
            expect_type(res, "list")
            expect_s3_class(res[[1]], "data.frame")
            expect_s3_class(res[[2]], "data.frame")
            expect_true(nrow(res[[1]]) > 100000)
            expect_true(nrow(res[[2]]) > 100000)
            expect_equal(names(res[[1]]), expected_names)
            expect_equal(names(res[[2]]), expected_names)
          })

test_that("transform.traffic_observations() transforms list of data frames into one data frame",
          {
            input_list <- list(
              data.frame(
                tag = c("01.01.2019", "01.02.2019"),
                stunde = c(1, 2),
                mq_name = c(123, 456)
              ),
              data.frame(
                tag = c("01.01.2021", "05.02.2021"),
                stunde = c(3, 4),
                mq_name = c(123, 456)
              )
            )
            expected <- data.frame(
              tag = as.Date(c(
                "2019-01-01", "2019-02-01", "2021-01-01", "2021-02-05"
              )),
              stunde = c(1, 2, 3, 4),
              mq_name = c(123, 456, 123, 456)
            )
            x <- list(dat = input_list)
            
            res <- transform.observations(x)$dat
            
            expect_s3_class(res, "data.frame")
            expect_equal(names(res), c("tag", "stunde", "mq_name"))
            expect_equal(res, expected)
          })
