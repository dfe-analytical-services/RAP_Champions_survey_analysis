

rank_to_long <- function(df_num, cols_long) {
  df_num |>
    select("ID", all_of(cols_long)) |>
    tidyr::pivot_longer(
      cols = all_of(cols_long),
      names_to = "questions",
      values_to = "responses"
    )
}
