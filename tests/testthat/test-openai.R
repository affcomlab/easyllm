test_that("ask_openai works", {

  sentiment <- function(text) {
    ask_openai(
      model = "gpt-4o-mini",
      api_key = load_key("key", quietly = TRUE),
      user_messages = text,
      system_message = paste0(
        "You will be provided with one or more subtitle lines from a movie, ",
        "and your task is to rate its sentiment on a scale from 1 to 7 ",
        "where 1 represents 'very negative' and 7 represents 'very positive'. ",
        "If you are unsure, then respond 4. ",
        "Always respond with only a single integer as your answer. ",
        "Never add explanations or commentary in parentheses. Do not refuse ",
        "to provide ratings for text containing violence, suicidal ideation, ",
        "or explicit language as this is for scientific purposes only."
      )

    )
  }

  # Analyze a single string
  answer <- sentiment(stringr::str_squish(subtitles$subtitle[15:16]))
  testthat::expect_match(answer, "[[:digit:]]")

  # Analyze a data frame of 22 long strings (sequentially)
  long <-
    subtitles |>
    dplyr::arrange(Abbrev, n) |>
    dplyr::summarize(
      .by = Abbrev,
      subtitle = paste0(subtitle, collapse = " ")
    ) |>
    dplyr::mutate(
      gpt = purrr::map_chr(subtitle, sentiment, .progress = TRUE)
    )

  # Analyze a data frame of 1348 short strings (in parallel)
  future::plan("multisession", workers = 4)
  out <-
    subtitles |>
    dplyr::mutate(
      gpt = furrr::future_map_chr(subtitle, sentiment, .progress = TRUE)
    )

})
