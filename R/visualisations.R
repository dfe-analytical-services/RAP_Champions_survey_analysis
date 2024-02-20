stacked_bar_chart <- function(df, questions, colours){



  # reshape the data
  # get proportion of each response for each question
  data_for_stacked_chart <- df %>%
    select(ID, all_of(ranked_columns)) %>%
    gather(question, response, -ID) %>%
    group_by(question, response) %>%
    summarise(count = n(), .groups = 'drop_last') %>%
    mutate(proportion = count / sum(count))

  # make columns factors, easier to plot and colour
  data_for_stacked_chart$response <- data_for_stacked_chart$response %>%
    factor(levels = ranking_factors)


  # plot
  data_for_stacked_chart %>%
    filter(question %in% questions) %>%
    ggplot(aes(x = question, y = proportion, fill = response)) +
    geom_bar(stat = 'identity') +
    coord_flip() +
    scale_fill_manual(values = colours) +
    theme_minimal()


}
