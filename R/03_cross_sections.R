# Cross sections (Messquerschnitte) ----


#' transform cross sections data (Messquerschnitte)
#' 
#' @description Bus lanes and left turn lanes are excluded because they
#' introduce a bias. They usually have low numbers of vehicles although they may
#' be in heavy traffic areas. That confuses the traffic model.
#' 
#' @param x single_source
#' @param ... other parameters
#'
#' @description transforms the cross sections metadata
#'
transform.cross_sections <- function(x, ...) {
  cross_sections <- x$dat
  cross_sections <- cross_sections %>%
    # Replace Ä with escape sequence
    rename(lon = !!("L\u00c4NGE.(WGS84)"),
           lat = !!("BREITE.(WGS84)"))
  names(cross_sections) <- tolower(names(cross_sections))
  cross_sections <- cross_sections %>%
    # Exclude bus lanes and left turn lanes
    filter(!.data$spur %in% c("BUS", "BUS_LKW", "LA")) %>% 
    select(mq_short_name = .data$mq_kurzname,
           .data$position,
           .data$pos_detail,
           .data$richtung,
           .data$lon,
           .data$lat,
           .data$mq_id15) %>%
    distinct()
  check_unique_key(cross_sections, "mq_id15")
  x$dat <- cross_sections
  x
}
