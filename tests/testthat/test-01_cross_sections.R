# Cross sections (Messquerschnitte) ----

test_that("extract.cross_sections() retrieves data", {
  x <- single_source("cross_sections",
                     sheet = "Stammdaten_TEU_20220720")
  res <- extract.default(x)$dat
  expect_s3_class(res, "data.frame")
  expect_true(nrow(res) >= 300)
  expect_equal(
    names(res),
    c(
      "MQ_KURZNAME",
      "DET_NAME_ALT",
      "DET_NAME_NEU",
      "DET_ID15",
      "MQ_ID15",
      "STRASSE",
      "POSITION",
      "POS_DETAIL",
      "RICHTUNG",
      "SPUR",
      "annotation",
      "LÄNGE.(WGS84)",
      "BREITE.(WGS84)",
      "INBETRIEBNAHME",
      "ABBAUDATUM",
      "DEINSTALLIERT",
      "KOMMENTAR"
    )
  )
})

test_that("transform.cross_sections() changes names as expected", {
  a_string <- rep("abc", 3)
  input_df <- data.frame(
    "LÄNGE.(WGS84)" = c(1, 2, 3),
    "BREITE.(WGS84)" = c(4, 5, 6),
    MQ_KURZNAME = c("la", "le", "li"),
    POSITION = a_string,
    POS_DETAIL = a_string,
    RICHTUNG = a_string,
    SOME_COL = a_string,
    SPUR = c("HR", "HR", "ABC"),
    MQ_ID15 = c("a", "b", "c"),
    check.names = FALSE
  )
  x <- list(dat = input_df)
  res <- transform.cross_sections(x)$dat
  expect_equal(
    names(res),
    c(
      "mq_short_name",
      "position",
      "pos_detail",
      "richtung",
      "lon",
      "lat",
      "mq_id15"
    )
  )
})
