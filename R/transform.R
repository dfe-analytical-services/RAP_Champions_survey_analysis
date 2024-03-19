

rank_to_long <- function(df_num, cols_long=ranked_columns, ...) {
  df_num |>
    select("ID", ..., all_of(cols_long)) |>
    tidyr::pivot_longer(
      cols = all_of(cols_long),
      names_to = "questions",
      values_to = "responses"
    )
}



# Cleaning qualitative columns
clean_word_col <- function(df, word_col) {
  df |>
    select(all_of(word_col)) |>
    unnest_tokens("Word", word_col) |>
    anti_join(stop_words, by = c("Word" = "word")) |> # anti_join just keeps the rows common to both data sets
    mutate(word = stringr::str_replace(Word, "'s", "")) |>
    count(word, sort = TRUE, name = "freq") |>
    # Most frequent words as top level
    mutate(word = factor(word, levels = rev(unique(word)))) |>
    ungroup()
}
