## code to prepare `subtitles` dataset goes here

subtitles <- readRDS("data-raw/subtitles_raw.rds")

usethis::use_data(subtitles, overwrite = TRUE)
