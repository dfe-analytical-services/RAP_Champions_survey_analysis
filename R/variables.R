
# ---- Column Names ----

## ---- New Column Names ----

new_column_names <- c("ID",
                      "Start_Time",
                      "End_Time",
                      "Email",
                      "Name",
                      "Division",
                      "Directorate",
                      "Group",
                      "repetitive_tasks",
                      "figuring_out_existing_processes_time_consuming",
                      "someone_else_could_run",
                      "re-run_old_versions",
                      "QA_manual_checks",
                      "I_use_code",
                      "comfortable_with_code",
                      "open_source_tools",
                      "know_how_to_open_source",
                      "version_control_confusing",
                      "understand_RAP",
                      "RAP_is_best",
                      "I_have_RAP_skills",
                      "I_have_RAP_time",
                      "I_have_RAP_support",
                      "manager_support",
                      "manager_encouragement",
                      "know_where_RAP_help",
                      "copy_and_paste_atm",
                      "collab_version_control_atm",
                      "factors_limiting_reproducibility",
                      "X",
                      "support_needed",
                      "projects_benefit_from_RAP",
                      "who_for_help",
                      "line_manager",
                      "someone_who_can_code_LM",
                      "confident_using_code_LM",
                      "comfortable_team_RAP_LM",
                      "understand_RAP_LM",
                      "confident_managing_RAP_LM",
                      "supported_by_seniors_LM",
                      "nervous_about_RAP_LM",
                      "know_where_help_LM",
                      "nervous_why_LM")



## ---- Likert Columns ----

ranked_columns <- c("repetitive_tasks",
                    "figuring_out_existing_processes_time_consuming",
                    "someone_else_could_run",
                    "re-run_old_versions",
                    "QA_manual_checks",
                    "I_use_code",
                    "comfortable_with_code",
                    "open_source_tools",
                    "know_how_to_open_source",
                    "version_control_confusing",
                    "understand_RAP",
                    "RAP_is_best",
                    "I_have_RAP_skills",
                    "I_have_RAP_time",
                    "I_have_RAP_support",
                    "manager_support",
                    "manager_encouragement",
                    "know_where_RAP_help",
                    "someone_who_can_code_LM",
                    "confident_using_code_LM",
                    "comfortable_team_RAP_LM",
                    "understand_RAP_LM",
                    "confident_managing_RAP_LM",
                    "supported_by_seniors_LM",
                    "nervous_about_RAP_LM",
                    "know_where_help_LM")

## ---- Yes/No Columns ----

y_n_cols <- c("copy_and_paste_atm",
              "collab_version_control_atm",
              "line_manager")


# ---- Likert Factors ----

ranking_factors <- c('Strongly agree',
                     'Agree',
                     'Neutral',
                     'Disagree',
                     'Strongly disagree')


# ---- Colours ----

# Use the analytical function colour palette

colours <- af_colours('categorical', 'hex', 5) %>%
  suppressMessages()

colours_sequential<- af_colours('sequential', 'hex') %>%
  suppressMessages()

# I wish we were in python with dictionary comprehension...
likert_colours <- c('Strongly agree' = colours[1],
                     'Agree' = colours[2],
                     'Neutral' = colours[3],
                     'Disagree' = colours[4],
                     'Strongly disagree' = colours[5])


likert_colours_sequential <- c('Agree' = colours_sequential[1],
                               'Neutral' = colours_sequential[2],
                               'Disagree' = colours_sequential[3]
                               )
