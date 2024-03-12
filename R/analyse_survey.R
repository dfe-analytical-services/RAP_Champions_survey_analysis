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

# put your division(s) in this list. "All" will keep all divisions.

choose_divisions <- c("Regions Group")

division_data <- RAP_full %>%
  filter_for_divisions(choose_divisions)

division_data_numerical <- RAP_full_numerical%>%
  filter_for_divisions(choose_divisions)



# ---- Statistics ----

## ---- Descriptive Statistics ----

# choose the columns you want
columns_for_stats <- c("I_use_code", "comfortable_with_code", "open_source_tools")

# generates statistical data for the columns selected above
# https://stackoverflow.com/questions/3418128/how-to-convert-a-factor-to-integer-numeric-without-loss-of-information
division_data_numerical %>%
  select(all_of(columns_for_stats)) %>%
  mutate(across(all_of(columns_for_stats), ~as.numeric(levels(.))[.])) %>%
  summary()


## ---- Correlation ----

# choose two columns to find correlation
column_1 <- "repetitive_tasks"
column_2 <- "figuring_out_existing_processes_time_consuming"

# get_correlation is a simple function in helpers.R
division_data_numerical %>%
  get_correlation(column_1, column_2)

# there's a scatter plot later too


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
  geom_bar(stat = "identity", fill = af_blue, colour = af_blue) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = max(counted_data$n))) +
  theme_minimal() +
  theme(panel.grid.minor = element_blank()) +
  labs(x = "Response", y = "Count", title = column_names_dictionary[column_to_plot])


## ---- Stacked Bar Chart ----

# Look in visualisations for the code for these stacked bar charts.

# put your selection of questions for the stacked chart here
choose_questions <- c("I_have_RAP_skills", "I_have_RAP_support", "I_have_RAP_time")

### ---- 5 Responses ----

# choose your own colour dictionary
# here ChatGPT has produced red to green hex values for me

division_data %>%
  stacked_bar_chart(choose_questions, likert_colours)

### ---- 3 Responses ----

# Here I have combined the positive responses and the negative responses to
# just get three types of response. Argument that it's easier to understand
# and it uses sequential colours, bit more boring but cleaner overall.

division_data %>%
  mutate(across(all_of(ranked_columns), ~recode_strongly_levels(.))) %>%
  stacked_bar_chart(choose_questions, likert_colours_sequential)


## ---- Scatter Plot ----

# for visualising correlation

# choose your columns
column_1_scatter <- "understand_RAP"
column_2_scatter <- "RAP_is_best"
colour_column <- "I_have_RAP_skills"

# you'll want to click the Zoom or Export button to see this properly
division_data %>%
  scatter_plot(column_1_scatter, column_2_scatter, colour_column)

# in case you want to see the correlation here too
division_data_numerical %>%
  get_correlation(column_1_scatter, column_2_scatter)


# you can also do one without colour
division_data %>%
    scatter_plot("I_use_code", "manager_encouragement")


division_data_numerical %>%
  get_correlation("I_use_code", "manager_encouragement")



# Counts of the summary stats

# Spider plots

# We are looking for information on:
# - Most common/important needs in your area
# - Biggest problems for people in your area when attempting RAP
# - Ideas to support the people in your area with RAP
