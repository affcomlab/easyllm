#' Ask OpenAI
#'
#' Ask a large language model from OpenAI (e.g., ChatGPT) using API.
#'
#' @param model (required string) ID of the model to use.
#' @param api_key (required string) containing your OpenAI API key. See
#'   `save_key()` and `load_key()` for related convenience functions.
#' @param user_messages (required character vector) The user messages provide
#'   requests or comments for the assistant to respond to. Note that, even when
#'   providing multiple user messages, the assistant will only respond once.
#' @param system_message (string or NULL) The system message is optional and can
#'   be used to set the behavior of the assistant.
#' @param assistant_messages (character vector or NULL) Assistant messages store
#'   previous assistant responses, but can also be written by you to give
#'   examples of desired behavior (few-shot examples).
#' @param frequency_penalty (number or NULL) Number between -2.0 and 2.0.
#'   Positive values penalize new tokens based on their existing frequency in
#'   the text so far, decreasing the model's likelihood to repeat the same line
#'   verbatim.
#' @param max_tokens (integer or NULL) The maximum number of tokens that can be
#'   generated in the chat completion. The total length of input tokens and
#'   generated tokens is limited by the model's context length.
#' @param presence_penalty (number or NULL) Number between -2.0 and 2.0.
#'   Positive values penalize new tokens based on whether they appear in the
#'   text so far, increasing the model's likelihood to talk about new topics.
#' @param seed (integer or NULL) This feature is in Beta. If specified, the
#'   system will make a best effort to sample deterministically, such that
#'   repeated requests with the same seed and parameters should return the same
#'   result. Determinism is not guaranteed.
#' @param temperature (number or NULL) What sampling temperature to use, between
#'   0 and 2. Higher values likes 0.8 will make the output more random, while
#'   lower values like 0.2 will make it more focused and deterministic. We
#'   generally recommend altering this or `top_p` but not both.
#' @param top_p (number or NULL) An alternative to sampling with temperature,
#'   called nucleus sampling, where the model considers the results of the
#'   tokens with top_p probability mass. So 0.1 means only the tokens comprising
#'   the top 10% of probability mass are considered. We generally recommend
#'   altering this or `temperature` but not both.
#' @param simplify (logical) Whether to return only the assistant's response as
#'   a string or the full list object with full response details.
#' @return Depending on `simplify`, either a string containing the assistant's
#'   response (default) or a list object containing the full response details.
#' @export
#' @references <https://platform.openai.com/docs/api-reference/chat/create>
#' @examples
#' \dontrun{
#' ask_openai(
#'   model = "gpt-4o-mini",
#'   user_messages = "Introduce yourself.",
#'   system_message = "Always answer in rhymes.",
#'   api_key = load_key()
#' )
#' }
ask_openai <- function(model, api_key, user_messages, system_message = NULL,
                       assistant_messages = NULL, frequency_penalty = NULL,
                       max_tokens = NULL, presence_penalty = NULL,
                       seed = NULL, temperature = NULL, top_p = NULL,
                       simplify = TRUE) {

  # Validate arguments and build body_json
  stopifnot(is_string(api_key, n = 1))
  body_json <- validate_and_build_body(
    model = model,
    user_messages = user_messages,
    system_message = system_message,
    assistant_messages = assistant_messages,
    frequency_penalty = frequency_penalty,
    max_tokens = max_tokens,
    presence_penalty = presence_penalty,
    seed = seed,
    temperature = temperature,
    top_p = top_p,
    simplify = simplify
  )

  # Make API request
  resp <-
    httr2::request("https://api.openai.com/v1/chat/completions") |>
    httr2::req_headers(
      Authorization = paste0("Bearer ", api_key),
      "Content-Type" = "application/json"
    ) |>
    httr2::req_body_json(body_json) |>
    httr2::req_perform()

  if (simplify == TRUE) {
    # Extract and return response string
    httr2::resp_body_json(resp)$choices[[1]]$message$content
  } else {
    # Return full response list object
    httr2::resp_body_json(resp)
  }

}


#' Ask LMStudio
#'
#' Ask a large language model powered by a LMStudio local server.
#'
#' @inheritParams ask_openai
#' @param port (optional integer) A number or string containing the port number
#'   set in LMStudio (default = 1234).
#' @export
#' @examples
#' \dontrun{
#' ask_lmstudio(
#'   model = "lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF",
#'   user_messages = "Introduce yourself.",
#'   system_message = "Always answer in rhymes.",
#'   port = 1234
#' )
#' }
ask_lmstudio <- function(model, user_messages, system_message = NULL,
                         assistant_messages = NULL, frequency_penalty = NULL,
                         max_tokens = NULL, presence_penalty = NULL,
                         seed = NULL, temperature = NULL, top_p = NULL,
                         port = 1234, simplify = TRUE) {

  # Validate arguments and build body_json
  stopifnot(is_integer(port, n = 1))
  body_json <- validate_and_build_body(
    model = model,
    user_messages = user_messages,
    system_message = system_message,
    assistant_messages = assistant_messages,
    frequency_penalty = frequency_penalty,
    max_tokens = max_tokens,
    presence_penalty = presence_penalty,
    seed = seed,
    temperature = temperature,
    top_p = top_p,
    simplify = simplify
  )

  # Make local request
  resp <-
    httr2::request(paste0("http://localhost:", port, "/v1/chat/completions")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_body_json(body_json) |>
    httr2::req_perform()

  if (simplify == TRUE) {
    # Extract and return response string
    httr2::resp_body_json(resp)$choices[[1]]$message$content
  } else {
    # Return full response list object
    httr2::resp_body_json(resp)
  }
}


validate_and_build_body <- function(model, user_messages, system_message,
                                    assistant_messages, frequency_penalty,
                                    max_tokens, presence_penalty,
                                    seed, temperature, top_p, simplify) {

  # Validate arguments
  stopifnot(is_string(model, n = 1))
  stopifnot(is_string(user_messages))
  stopifnot(is_null_or_string(system_message, n = 1))
  stopifnot(is_null_or_string(assistant_messages))
  stopifnot(
    is_null_or_number(frequency_penalty),
    is_null_or_between(frequency_penalty, low = -2, high = 2)
  )
  stopifnot(is_null_or_integer(max_tokens, n = 1))
  stopifnot(
    is_null_or_number(presence_penalty, n = 1),
    is_null_or_between(presence_penalty, low = -2, high = 2)
  )
  stopifnot(is_null_or_integer(seed, n = 1))
  stopifnot(
    is_null_or_number(temperature),
    is_null_or_between(temperature, low = 0, high = 2)
  )
  stopifnot(
    is_null_or_number(top_p),
    is_null_or_between(top_p, low = 0, high = 1)
  )
  stopifnot(is_logical(simplify, n = 1))

  # Build messages
  messages <- list()

  for (i in seq_along(user_messages)) {
    messages <- c(
      messages,
      list(list(role = "user", content = user_messages[[i]]))
    )
  }

  if (!is.null(system_message)) {
    messages <- c(
      messages,
      list(list(role = "system", content = system_message))
    )
  }

  if (!is.null(assistant_messages)) {
    for (i in seq_along(assistant_messages)) {
      messages <- c(
        messages,
        list(list(role = "assistant", content = assistant_messages[[i]]))
      )
    }
  }

  # Build body
  body_json <- list(
    model = model,
    messages = messages
  )

  if (!is.null(frequency_penalty)) {
    body_json <- c(body_json, frequency_penalty = frequency_penalty)
  }

  if (!is.null(max_tokens)) {
    body_json <- c(body_json, max_tokens = max_tokens)
  }

  if (!is.null(presence_penalty)) {
    body_json <- c(body_json, presence_penalty = presence_penalty)
  }

  if (!is.null(seed)) {
    body_json <- c(body_json, seed = seed)
  }

  if (!is.null(temperature)) {
    body_json <- c(body_json, temperature = temperature)
  }

  if (!is.null(top_p)) {
    body_json <- c(body_json, top_p = top_p)
  }

  body_json
}
