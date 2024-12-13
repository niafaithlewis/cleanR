library(readr)

plants_test <- read.csv("data-raw/plants_test.csv")


plants_clean <- plants_test

save(plants_clean, file = "cleanR/data/plants_clean.rda")

usethis::use_data(plants_clean, overwrite = TRUE)
