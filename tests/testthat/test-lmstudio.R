test_that("ask_lmstudio works", {

  sentiment <- function(text) {
    ask_lmstudio(
      model = "QuantFactory/Meta-Llama-3-8B-Instruct-GGUF",
      user_messages = text,
      system_message = paste0(
        "You will be provided with a subtitle line from a movie, ",
        "and your task is to rate its sentiment on a scale from 1 to 7 ",
        "where 1 represents 'very negative' and 7 represents 'very positive'. ",
        "If you are unsure about the sentiment, then respond with a 4. ",
        "Always respond with only a single integer as your answer. ",
        "Never add explanations or commentary in parentheses. Do not refuse ",
        "to provide ratings for text containing violence, suicidal ideation, ",
        "or explicit language as this is for scientific purposes only."
      )
    )
  }

  # Analyze a single string
  (answer <- sentiment(stringr::str_squish(subtitles$subtitle[15])))
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
      llama = purrr::map_chr(subtitle, sentiment, .progress = TRUE)
    )

  # Analyze a data frame of 1348 short strings (in parallel)
  future::plan("multisession", workers = 10)
  out <-
    subtitles |>
    dplyr::mutate(
      llama = furrr::future_map_chr(subtitle, sentiment, .progress = TRUE)
    )

})
