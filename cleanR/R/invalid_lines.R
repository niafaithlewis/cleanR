#' Detect Invalid 'line' Values in a Dataset
#'
#' This function is specific to a feature of my research and my plants_clean dataset. It identifies rows in the dataset where the values in the `line` column
#' deviate from the expected pattern (i.e., "C1", "SC1", or "SI1"). It returns a 
#' data frame with the rows that contain invalid `line` values and suggests possible corrections.
#'
#' @param data A data frame that contains the dataset with a `line` column.
#' @name detect_invalid_lines
#' @return A data frame with rows where the `line` column contains invalid values, along with suggested corrections.
#' @examples
#' # Example dataset
#' plantdata <- data.frame(
#'   treatment = c("d", "d", "d", "wet", "d", "w"),
#'   pot_id = c(1, 2, 3, 4, 5, 6),
#'   line = c("C1", "SXX1", "SC1", "SI1", "C1", "C1"),
#'   mom = c(86, 225, 231, 672, 2, 27),
#'   dad = c(59, 258, 245, 697, 44, 100),
#'   tray_id = c(1, 10, 1, 1, 1, 1),
#'   dry_weight = c(165, 168, 158, 170, 172, 160)
#' )
#' 
#' # Detect invalid 'line' values
#' invalid_lines <- detect_invalid_lines(plantdata)
#' print(invalid_lines)
#' 
#' @export
detect_invalid_lines <- function(data) {
  
  ### Accepted values for the 'line' column:
  valid_patterns <- c("C1", "SC1", "SI1")
  
  ### Regex for filtering 
  valid_regex <- "^(C1|SC1|SI1)$"
  
  ### Remove whitespace
  data$line <- trimws(data$line)  # Remove leading/trailing whitespace
  
  ### Identify invalid 'line' values
  ### Case-insensitive
  invalid_entries <- data[!grepl(valid_regex, data$line, ignore.case = TRUE), ]
  
  ### Suggest corrections via JW - string distance
  if (nrow(invalid_entries) > 0) {
    message("The following rows contain invalid 'line' values:")
    invalid_entries$suggested_correction <- apply(invalid_entries, 1, function(row) {
      line_value <- row["line"]
      distances <- stringdist::stringdist(line_value, valid_patterns, method = "jw")
      closest_match <- valid_patterns[which.min(distances)]
      return(closest_match)
    })
    print(invalid_entries)
  } else {
    message("All 'line' values are valid.")
  }
  
  return(invalid_entries)
}
