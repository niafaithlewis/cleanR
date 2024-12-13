library(readr)

plants_test <- read.csv("data-raw/plants_test.csv")

usethis::use_data(plants_test, overwrite = TRUE)

plants_clean <- plants_test

save(plants_clean, file = "data/plants_clean.rda")

usethis::use_data(plants_clean, overwrite = TRUE)
