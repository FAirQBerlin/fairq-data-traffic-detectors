#' Extract for measured traffic intensity and velocity
#' @param x single_source
#' @param ... other parameters
#'
#' @description load the traffic data from the web
extract.observations <- function(x, ...) {
  x$dat <- lapply(x$urls$url,
                  function(url) {
                    flog.info(paste("Retreiving data from", url))
                    read_delim(url,
                               col_types = "ccidiiiiii",
                               delim = ";") %>%
                      distinct()
                  })
  x
}

#' Transform for measured traffic intensity and velocity
#' @param x single_source
#' @param ... other parameters
#'
#' @description rename columns for traffic observations
transform.observations <- function(x, ...) {
  traffic_observations_list <- x$dat
  traffic_observations <- traffic_observations_list %>%
    bind_rows() %>%
    mutate(tag = as.Date(.data$tag, format = "%d.%m.%Y")) %>%
    distinct()
  check_unique_key(traffic_observations, c("tag", "stunde", "mq_name"))
  x$dat <- traffic_observations
  x
}
