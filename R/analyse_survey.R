

# ---- Load Packages ----

library(here)
library(ggplot2)
library(tidyr)
library(afcolours)
library(forcats)
source(here('R', 'helpers.R'))
source(here('R', 'load_data.R'))
source(here('R', 'visualisations.R'))



# ---- Get Data by Division ----

# put your division(s) in this function. "All" will keep all divisions.
division_data <- RAP_full %>%
  filter_for_divisions("All")


# ---- Basic Plots ----

## ---- Bar Chart ----

# choose the column to plot
column_to_plot <- "comfortable_with_code"

# produce counted dataframe
counted_data <- division_data %>%
  count(.data[[column_to_plot]], .drop = FALSE)

# plot
counted_data %>%
  ggplot(aes(x = .data[[column_to_plot]], y = n)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Response", y = "Count", title = column_names_dictionary[column_to_plot])


## ---- Stacked Bar Chart ----

# Look in visualisations for the code for these stacked bar charts.

# put your selection of questions for the stacked chart here
choose_questions <- c("I_have_RAP_skills", "I_have_RAP_support", "I_have_RAP_time")

### ---- 5 Responses ----

# bit of a problem with colour in the 5-response version
# af_colours doesn't like using 5 colours
# you could just define your own colour sequence tbh

division_data %>%
  stacked_bar_chart(choose_questions, likert_colours)


### ---- 3 Responses ----

# Here I have combined the positive responses and the negative responses to
# just get three types of response. Argument that it's easier to understand
# and it uses sequential colours, bit more boring but cleaner overall.

division_data %>%
  mutate(across(all_of(ranked_columns), ~recode_strongly_levels(.))) %>%
  stacked_bar_chart(choose_questions, likert_colours_sequential)



