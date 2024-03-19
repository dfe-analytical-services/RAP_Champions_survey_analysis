library(forcats)

get_path_to_data <- function(file_name){

  # get user's username
  username <- Sys.info()[["user"]]

  # get filepath
  filepath <- paste0(
    "C:\\Users\\",
    username,
    "\\Department for Education\\DfE RAP champions - General\\survey_data\\",
    file_name,
    '.csv'
  )


  return(filepath)

}



#' Filter RAP survey by division
#'
#' @param df dataframe, RAP survey joined to org data.
#' @param ... any division name in DfE. Also accepts "All".
#'
#' @return division_data, a dataframe filtered by division.
#' @export
#'
#' @examples
filter_for_divisions <- function(df, divisions_list){


  if('all' %in% divisions_list | 'All' %in% divisions_list){
    return(df)
  }

  division_data <- df %>%
    filter(grepl(paste(divisions_list, collapse = "|"), division), fixed = TRUE)

  return(division_data)


}




recode_strongly_levels <- function(x){

  # This function recodes the 'Strongly agree' and 'Strongly disagree' levels
  # to 'Agree' and 'Disagree'

  x %>% fct_recode("Disagree" = "Strongly disagree", "Agree" = "Strongly agree")

}



get_correlation <- function(df, col1, col2){

  # this function takes a dataframe and gets the correlation between two
  # of its columns

  x <- df[[col1]] %>%
    as.numeric()

  y <- df[[col2]] %>%
    as.numeric()


  return(cor(x, y))


}


# Convert factors to numeric (their physical value not level)
as.numeric_factor <- function(fct) {
  as.numeric(levels(fct))[fct]
}


# Insert line breaks every 6 words (for plotting labels)
insert_line_breaks <- function(x, freq=5) {
  sapply(strsplit(as.character(x), " "), function(x) {
    words <- unlist(strsplit(x, " "))
    words_with_breaks <- sapply(seq_along(words), function(i) {
      if (i %% freq == 0) {
        return(paste(words[i], "\n"))
      } else {
        return(words[i])
      }
    })
    paste(words_with_breaks, collapse = " ")
  })
}

