#' Create date from year and month
#'
#' @param df data.frame with columns "Monat" and "Jahr" (both numeric)
#' @export
add_date_year_month <- function(df) {
  df %>%
    mutate(
      Monat = formatC(.data$Monat, width = 2, flag = "0"),
      Datum = as.Date(paste0(.data$Jahr, .data$Monat, "01"), format = "%Y%m%d")
    )
}

#' Transform number to weekday abbreviation
#'
#' @description For example, 1 is "Mo", 0 is "So", but 7 is "So" too
#'
#' @param x a number
#'
#' @export
number_to_weekday <- function(x) {
  wday(x %% 7 + 1, label = TRUE, week_start = 1)
}


#' Make data longer
#'
#' @param df data.frame with traffic detector data
#' @param names_prefix Name for the new value column; this prefix plus "_" is removed from the
#' names of the columns filling the value column
#' @param cols columns to fill the new long value column
#'
#' @export
vehicle_types_to_row <- function(df, names_prefix, cols) {
  df %>%
    pivot_longer(
      cols = all_of(cols),
      values_to = names_prefix,
      names_prefix = paste0(names_prefix, "_"),
      names_to = "Fahrzeugtyp"
    )
}
