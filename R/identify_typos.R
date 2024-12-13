#' Identify Potential Typos in Text Data
#'
#' This function flags values that deviate from the two most expected treatment values
#' or a set of user-defined expected values as potential typos.
#'
#' @param data A character vector containing the treatment values.
#' @param expected_values A vector of the two most expected treatment values (optional).
#' @return A data frame of the original values and whether they were flagged as potential typos.
#' @name identify_typos
#' @export
#'
#' @examples
#' identify_typos(c("d", "w", "wet", "dry", "w", "d", "dr", "w", "d", "d"))
identify_typos <- function(data, expected_values = NULL) {
  
  ### Make sure input contains characters 
  if (!is.character(data)) {
    
    ### If not, warning message 
    stop("Input data must be a character vector.")
  }
  
  ### Remove NAs and blank strings
  data <- data[!stringr::str_detect(data, "^\\s*$") & !is.na(data)]
  
  ### If user provides no expected values, find the two most frequent values
  if (is.null(expected_values)) {
    expected_values <- names(sort(table(data), decreasing = TRUE)[1:2])
    message("The two most expected values identified are: ", paste(expected_values, collapse = ", "))
  }
  
  ### Flag values that are not in the list of expected values
  flagged <- !(data %in% expected_values)
  
  ### Make a data frame displaying potential typos 
  potential_typos <- data.frame(
    Original = data,
    Flagged = flagged,
    stringsAsFactors = FALSE
  )
  
  ### Print the flagged rows 
  flagged_rows <- potential_typos[potential_typos$Flagged, ]
  if (nrow(flagged_rows) > 0) {
    message("The following values were flagged as potential typos:")
    print(flagged_rows)
  } else {
    message("No typos detected.")
  }
  
  #### Return the result as a data frame
  return(potential_typos)
}

