#' Coerce Numeric Columns
#'
#' This function takes a column that a user assumes should have numeric inputs and 
#' identifies any values that have been stored as text. 
#' This function coerces them to numeric, drops any rows that have been coerced to "NA", and 
#' prints the changes in a dataframe. 
#'
#' @param data A data frame containing the dataset.
#' @param numeric_columns A character vector of column names expected to be numeric.
#' @return A data frame with specified columns coerced to numeric, changes made, and problematic rows dropped.
#' @examples
#' updated_data <- coerce_numeric_columns(plants_clean, numeric_columns = c("X10_9_weight"))
#' @export
coerce_numeric_columns <- function(data, numeric_columns) {
  for (col in numeric_columns) {
    if (!col %in% colnames(data)) {
      warning(paste("Column", col, "not found in the dataset. Skipping."))
      next
    }
    
    ### Extract column values as character 
    raw_values <- as.character(data[[col]])
    
    ### Coerce all values to numeric
    coerced_values <- suppressWarnings(as.numeric(raw_values))
    
    ### Find problematic values
    is_problematic <- is.na(coerced_values) & !is.na(raw_values)
    problematic_values <- raw_values[is_problematic]
    
    
    ### Warnings
    if (length(problematic_values) > 0) {
      message(paste("Non-numeric values detected in column", col, ":"))
      print(data.frame(Observation = which(is_problematic), Value = problematic_values))
    }
    
    ### Drop rows with problematic values
    problematic_rows <- which(is_problematic)
    if (length(problematic_rows) > 0) {
      
      ### Notify user of dropped rows 
      message(paste("Dropping rows:", paste(problematic_rows, collapse = ", "), 
                    "due to non-numeric values in column", col, "."))
      data <- data[-problematic_rows, ]

      next
    }
    
    ### Assign coerced values back to the column
    data[[col]] <- coerced_values
  }
  
  ### Return dataset
  return(data)
}


