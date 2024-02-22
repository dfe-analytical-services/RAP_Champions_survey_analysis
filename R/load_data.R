
# ---- Packages ----

library(dplyr)
library(here)

# load variables from the variables.R file
source(here('R', 'variables.R'))


# ---- Load Data ----

##  RAP survey ----

survey_path <- get_path_to_data("RAP-survey-results")
rap_survey <- read.csv(survey_path, check.names = F)

# get a dictionary of new (clean) names to old names
original_names <- rap_survey %>%
  colnames()

column_names_dictionary <- list()
i <- 1
for (nm in original_names){
  column_names_dictionary[new_column_names[i]] = nm
  i = i + 1
}



## Organogram ----

org_path <- get_path_to_data("organogram-data-2024-02-15")
org <- read.csv(org_path) %>%
  select(id, division, directorate, profession_1)




# ---- Join Data ----

# change col names. I have chosen some clean column names I think make sense,
# but happy to change them if people can think of better ones
colnames(rap_survey) <- new_column_names

# lower case email for joining with org
rap_survey <- rap_survey %>%
  mutate(Email = tolower(Email))

RAP_full <- rap_survey %>%
  left_join(org, by = join_by(Email == id)) %>%
  select(-Division, -Directorate)



# ---- Standardised Cleaning ----

# Turn ranked questions into factor column
RAP_full[ranked_columns] <- lapply(RAP_full[ranked_columns], factor, levels = ranking_factors)



# Turn Y/N questions into T/F
# Empty responses -> NA
RAP_full <- RAP_full %>%
  rowwise() %>%
  mutate(across(all_of(y_n_cols), ~ifelse(.=="", NA, .)),
         across(all_of(y_n_cols), ~ifelse(. == 'Yes', T, ifelse(is.na(.), ., F)))) %>%
  ungroup()



# ---- Numerical Version ----

# we have to turn the values into numerical data for some things -- I have just
# used a five point scale from 0 - 4, strongly disagree - strongly agree.
RAP_full_numerical <- RAP_full %>%
  rowwise() %>%
  mutate(across(all_of(ranked_columns), ~likert_scale_dictionary[as.character(.)])) %>%
  ungroup()

# make columns factors
RAP_full_numerical[ranked_columns] <- lapply(RAP_full_numerical[ranked_columns],
                                                  factor,
                                                  levels = numerical_ranking_factors)

