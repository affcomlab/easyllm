test_that("prompt_local works", {

  answer <- prompt_local(
    prompt = paste0(
      "Rate the following text (which is a subtitle from a movie) ",
      "on how negative to positive its sentiment is. ",
      "Respond only with a single integer from 1 to 7, ",
      "where 1 represents very negative and 7 represents very positive. ",
      "Here is the text: ",
      subtitles[[15, "subtitle"]]
    ),
    model = "lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF",
    context = NULL,
    port = 1234,
    temperature = 0
  )
  testthat::expect_match(answer, "[[:digit:]]")

})
