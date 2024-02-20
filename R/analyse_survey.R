

# ---- Load Packages ----

library(here)
library(ggplot2)
source(here('R', 'helpers.R'))
source(here('R', 'load_data.R'))





# ---- Get Data by Division ----

# put your division(s) in this function. "All" will keep all divisions.
division_data <- RAP_full %>%
  filter_for_divisions("All")


# ---- Basic Plots ----

## ---- Bar Chart ----

column_to_plot <- "comfortable_with_code"

division_data %>%
  count(.data[[column_to_plot]], .drop = FALSE) %>%
  ggplot(aes(x = .data[[column_to_plot]], y = n)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Response", y = "Count", title = column_names_dictionary[column_to_plot])

