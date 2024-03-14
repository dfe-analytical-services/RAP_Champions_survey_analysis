stacked_bar_chart <- function(df, questions, colours){



  # reshape the data
  # get proportion of each response for each question
  data_for_stacked_chart <- df %>%
    select(ID, all_of(ranked_columns)) %>%
    pivot_longer(all_of(ranked_columns),
                 names_to = "question",
                 values_to = "response") %>%
    group_by(question, response) %>%
    summarise(count = n(), .groups = 'drop_last') %>%
    mutate(proportion = count / sum(count))

  # # make columns factors, easier to plot and colour
  # data_for_stacked_chart$response <- data_for_stacked_chart$response %>%
  #   factor(levels = rev(ranking_factors))


  # plot
  data_for_stacked_chart %>%
    filter(question %in% questions) %>%
    ggplot(aes(x = question, y = proportion, fill = response)) +
    geom_bar(stat = 'identity') +
    coord_flip() +
    scale_fill_manual(values = colours) +
    theme_minimal()


}





scatter_plot <- function(df, question1, question2, colour_col = NULL){

  # function to create a scatter plot from columns.

  scatter_columns <- c(question1, question2)

  division_data_scatter <- df %>%
    rowwise() %>%
    mutate(across(all_of(scatter_columns), ~likert_scale_dictionary[as.character(.)])) %>%
    ungroup()

  # make columns factors
  division_data_scatter[scatter_columns] <- lapply(division_data_scatter[scatter_columns],
                                                   factor,
                                                   levels = numerical_ranking_factors)

  # scatter plot (with jitter added)
  # might be worth clicking Zoom or exporting this one, because of legends
  if (is.null(colour_col)){

    division_data_scatter %>%
      ggplot(aes(x = .data[[question1]],
                 y = .data[[question2]])) +
      geom_jitter() +
      labs(x = column_names_dictionary[question1],
           y = column_names_dictionary[question2]) +
      theme_minimal()
    }else{

    division_data_scatter %>%
      ggplot(aes(x = .data[[question1]],
                 y = .data[[question2]],
                 colour = .data[[colour_col]])) +
        geom_jitter() +
        labs(x = column_names_dictionary[question1],
             y = column_names_dictionary[question2],
             colour = column_names_dictionary[colour_col]) +
        scale_colour_manual(values = likert_colours) +
        theme_minimal()

  }




}



waffle_pop_plot <- function(df_div,
                            df_all = RAP_full) {

  div_pop <- nrow(df_div)
  total_pop <- nrow(df_all)

  plot_pop <- data.frame(group = c("Regions Group", "Total"),
                         respondents = c(div_pop, total_pop))

  division_nm <- DescTools::Mode(df_div$Group)[[1]]
  rg_perc_respond <- floor(div_pop/total_pop*100)


  ggplot(plot_pop, aes(fill = group, values = respondents)) +
    geom_waffle(n_rows = 8, size = 0.33, colour = "white") +
    scale_fill_manual(name = NULL,
                      values = af_colours(type = "focus", 'hex') |> suppressMessages()) +
    coord_equal() +
    theme_void() +
    labs(title = glue("{division_nm} made up {rg_perc_respond}% of responses"),
         subtitle = paste0("Waffle plot to show the number of responses to the RAP survery",
                           " in columns of 8")) +
    theme(legend.position = "bottom")
}
