#' Prompt Local LLM
#'
#' Prompt local large language model from LMStudio
#'
#' @param prompt A required string containing the prompt to give the LLM.
#' @param model A required string containing the model name in LMStudio.
#' @param context Either NULL or a string containing the system context to give
#'   the LLM (default = NULL).
#' @param port A number or string containing the port number set in LMStudio
#'   (default = 1234).
#' @param temperature A number representing how random vs. deterministic the
#'   output is. Set to 0 to always get the same response.
#' @return A string containing the LLM's response to your prompt.
#' @export
#' @examples
#' prompt_local(
#'   prompt = "Introduce yourself.",
#'   context = "Always answer in rhymes.",
#'   model = "lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF"
#' )
prompt_local <- function(prompt, model, context = NULL, port = 1234, temperature = 0) {

  if (is.null(context)) {
    body_json <- list(
      model = model,
      messages = list(
        list(
          role = "user",
          content = prompt
        )
      ),
      temperature = temperature,
      max_tokens = -1,
      stream = FALSE
    )
  } else {
    body_json <- list(
      model = model,
      messages = list(
        list(
          role = "system",
          content = context
        ),
        list(
          role = "user",
          content = prompt
        )
      ),
      temperature = temperature,
      max_tokens = -1,
      stream = FALSE
    )
  }

  resp <-
    httr2::request(paste0("http://localhost:", port, "/v1/chat/completions")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_body_json(body_json) |>
    httr2::req_perform()

  httr2::resp_body_json(resp)$choices[[1]]$message$content
}

#' Prompt OpenAI API
#'
#' Prompt local large language model from OpenAI using API.
#'
#' @param prompt A required string containing the prompt to give the LLM.
#' @param model A required string containing the model name in OpenAI's API.
#' @param context Either NULL or a string containing the system context to give
#'   the LLM (default = NULL).
#' @param key A required string containing your API key. See `save_key()` and
#'   `load_key()` for related convenience functions.
#' @param temperature A number representing how random vs. deterministic the
#'   output is. Set to 0 to always get the same response.
#' @return A string containing the LLM's response to your prompt.
#' @export
#' @examples
#' prompt_openai(
#'   prompt = "Introduce yourself.",
#'   model = "gpt-4o-mini",
#'   context = "Always answer in rhymes.",
#'   key = load_key()
#' )
prompt_openai <- function(prompt, model, context, key, temperature = 0) {

  if (is.null(context)) {
    body_json <- list(
      model = model,
      messages = list(
        list(
          role = "user",
          content = prompt
        )
      ),
      temperature = temperature
    )
  } else {
    body_json <- list(
      model = model,
      messages = list(
        list(
          role = "system",
          content = context
        ),
        list(
          role = "user",
          content = prompt
        )
      ),
      temperature = temperature
    )
  }

  resp <-
    httr2::request("https://api.openai.com/v1/chat/completions") |>
    httr2::req_headers(
      Authorization = paste0("Bearer ", key),
      "Content-Type" = "application/json"
    ) |>
    httr2::req_body_json(body_json) |>
    httr2::req_perform()

  httr2::resp_body_json(resp)$choices[[1]]$message$content
}
