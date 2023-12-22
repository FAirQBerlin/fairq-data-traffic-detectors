check_unique_key <- function(df, key_columns) {
  nrow_df <- nrow(df)
  n_key_combinations <- df %>%
    select(!!key_columns) %>%
    distinct() %>%
    nrow
  if (nrow_df != n_key_combinations) {
    key_cols_pasted <- paste(key_columns, sep = ", ")
    stop(paste(
      "The column(s)",
      key_cols_pasted,
      "don't provide a unique key."
    ))
  }
}
