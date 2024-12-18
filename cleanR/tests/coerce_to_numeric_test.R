library(cleanR)

# Load the data
file_path <- system.file("extdata", "plants_test.csv", package = "cleanR")
plants_test <- read.csv(file_path)

# Example usage
updated_data <- coerce_numeric_columns(
  data = plants_clean, 
  numeric_columns = c("X10_9_weight")
)


print(updated_data)




