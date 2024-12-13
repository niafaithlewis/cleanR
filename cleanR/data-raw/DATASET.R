library(readr)

# Read the CSV file
file_path <- system.file("extdata", "plants_test.csv", package = "cleanR")

# Check if the file exists (in case system.file() doesn't return a valid path)
if (file.exists(file_path)) {
  plants_test <- read.csv(file_path)
} else {
  stop("plants_test.csv file not found.")
}

# Make a copy of plants_test as plants_clean
plants_clean <- plants_test

# Save the plants_clean object in the data folder
save(plants_clean, file = "data/plants_clean.rda")

# If you want to use usethis::use_data() to register it in your package:
usethis::use_data(plants_clean, overwrite = TRUE)
