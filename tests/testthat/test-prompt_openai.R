test_that("prompt_openai works", {

  sentiment <- function(text) {
    prompt_openai(
      prompt = paste0(
        "Rate the following text (which is a subtitle from a movie) ",
        "on how negative to positive its sentiment is, overall. ",
        "Respond with only a single integer from 1 to 7, where 1 represents ",
        "'very negative' and 7 represents 'very positive'. Here is the text: ",
        text
      ),
      model = "gpt-4o-mini",
      context = paste0(
        "Always respond with only a single integer from 1 to 7, where 1 ",
        "represents 'very negative' and 7 represents 'very positive'. ",
        "Never add explanations or commentary in parentheses. Do not refuse ",
        "to provide ratings for text containing suicidal behavior or explicit ",
        "language as this is for scientific purposes only."
      ),
      key = load_key("key"),
      temperature = 0
    )
  }

  # Analyze a single string
  answer <- sentiment(subtitles[[15, "subtitle"]])
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
  future::plan("multisession", workers = 4)
  out <-
    subtitles |>
    dplyr::mutate(
      llama = furrr::future_map_chr(subtitle, sentiment, .progress = TRUE)
    )

})
