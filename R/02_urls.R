# Helpers ----

detector_meta_url <- function() {
  paste0(
    "https://mdhopendata.blob.core.windows.net/verkehrsdetektion/",
    "Stammdaten_Verkehrsdetektion_2022_07_20.xlsx"
  )
}


create_urls <- function(max_month = list(year = 2023, month = 8)) {
  max_year <- max_month$year
  min_year <- 2015
  years <- seq(min_year, max_year)
  months <- seq(1, 12)
  url_start <-
    "https://mdhopendata.blob.core.windows.net/verkehrsdetektion/"
  
  expand.grid(month = months, year = years) %>%
    filter(!((.data$year == max_month$year) &
               (.data$month > max_month$month)
    )) %>%
    mutate(
      month = sprintf("%02d", .data$month),
      subfolder =
        # case_when would be cleaner but causes failed test on Jenkins
        # see https://github.com/INWT/fairq-data-traffic-detectors/pull/28
        ifelse (
          .data$year == 2021,
          "Messquerschnitt/",
          ifelse(
            .data$year == 2023,
            "Messquerschnitte%20(fahrtrichtungsbezogen)/",
            "Messquerschnitt%20(fahrtrichtungsbezogen)/"
          )
        ),
      url = paste0(
        url_start,
        .data$year,
        "/",
        .data$subfolder,
        "mq_hr_",
        .data$year,
        "_",
        .data$month,
        ".csv.gz"
      )
    )
}
