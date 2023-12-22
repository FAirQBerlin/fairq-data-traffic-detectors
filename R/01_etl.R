etl <- function(x, ...) {
  logging("Extract: %s", x$name)
  x <- extract(x, ...)
  logging("Transform: %s", x$name)
  x <- transform(x, ...)
  logging("Load: %s", x$name)
  lload(x, ...)
  x
}

extract <- function(x, ...) UseMethod("extract")
transform <- function(x, ...) UseMethod("transform")
# to avoid name clash with base::load -> l(ocal)load:
lload <- function(x, ...) UseMethod("load")

extract.NULL <- function(x, ...) {
  log_debug("Skipping extract because of NULL value")
  NULL
}
transform.NULL <- function(x, ...) {
  log_debug("Skipping transform because of NULL value")
  NULL
}
load.NULL <- function(x, ...) {
  log_debug("Skipping load because of NULL value")
  NULL
}

extract.default <- function(x, ...) {
  log_debug("Entering 'default' extract method for '%s'", x$name)

  x$dat <- x$get_data(
    detector_meta_url(),
    sheet = x$sheet,
    ...)
  if (nrow(x$dat) == 0) x <- NULL
  x
}

transform.default <- function(x, ...) {
  log_debug("Entering 'default' transform method for '%s'", x$name)
  x
}

load.default <- function(x, ...) {
  log_debug("Entering 'default' lload method for '%s'", x$name)
  do.call(
    x$send_data,
    list(df = x$dat, table = x$load_table, mode = x$load_mode)
  )
}
