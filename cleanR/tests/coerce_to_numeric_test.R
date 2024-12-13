library(cleanR)

# Load the data
plants_clean <- read.csv("/cloud/project/cleanR/data-raw/plants_test.csv")

# Example usage
updated_data <- coerce_numeric_columns(
  data = plants_clean, 
  numeric_columns = c("X10_9_weight")
)


print(updated_data)




