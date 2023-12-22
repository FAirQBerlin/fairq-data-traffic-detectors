#' Data sources to query from
#'
#' List data sources. This list defines which tables to extract.
#'
#' @export
#' @rdname single_source
data_sources <- function() {
  list(
    single_source("cross_sections",
                  sheet = "Stammdaten_TEU_20220720"),
    single_source("observations",
                  urls = create_urls())
  )
}


#' Single source

#' @param name (character) a unique name used as class and to identify target
#'   table on database.
#' @param get_data (function)
#' @param send_data (function)
#' @param ... arguments used within methods and available for queries
#' @param load_mode (character) the mode in which we load data.
#' @param load_table (character) the table in which we load data.
#'
#' @export
#' @rdname single_source
single_source <- function(name,
                          get_data = read.xlsx,
                          # Need :: to avoid confusion in namespace
                          send_data = fairqDbtools::send_data,
                          load_mode = "replace",
                          load_table = paste0("traffic_det_", name),
                          ...) {
  # name (character) defines the class and is used for logging
  # get_data (function) a function that given the name and ... can extract data
  # ... passed to send data or otherwise used by methods
  out <- list(
    name = name,
    get_data = get_data,
    send_data = send_data,
    load_mode = load_mode,
    load_table = load_table,
    ...
  )
  class(out) <- c(name, "list")
  out
}
