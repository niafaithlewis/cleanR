# tests/testthat/test_typo_detection.R

library(testthat)
library(cleanR)
library(readxl)

# Test 2: Check if the function can read and process the plants data properly
test_that("Plants data typo detection works", {
  # Load the data
  plants_clean <- read.csv("/cloud/project/cleanR/data-raw/plants_test.csv")
  
  # Apply the typos function to the 'treatment' column
  potential_typos <- identify_typos(plants_clean$treatment)
  
  # Check that potential_typos is not NULL
  expect_true(length(potential_typos) > 0, "No typos detected!")
})
