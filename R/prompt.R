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
#'   model = "lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF"
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

#' Save an API key
#'
#' Save an API key string to a config file for easier use later.
#'
#' @param key A string containing the API key
#' @param keyname An optional string containing the name of the key (to store
#'   multiple keys for use with `load_key()`).
#' @export
#' @examples
#' save_key("MY-KEY-HERE", keyname = "openai")
save_key <- function(key, keyname = "key") {
  config_dir <- rappdirs::user_config_dir("lmprompt", "R")
  keyfile <- file.path(config_dir, paste0(keyname, ".rds"))
  if (file.exists(keyfile)) {
    saveRDS(key, keyfile)
    cli::cli_inform("Keyfile updated.")
  } else {
    if (!dir.exists(config_dir)) dir.create(config_dir, recursive = TRUE)
    saveRDS(key, keyfile)
    cli::cli_inform("Keyfile created.")
  }
}

#' Load an API key
#'
#' Load an API key string from a config file created by `save_key()`.
#'
#' @param keyname An optional string containing the name of the key
#' @return A string containing the loaded key.
#' @export
#' @examples
#' key <- load_key("openai")
#'
load_key <- function(keyname = "key") {
  config_dir <- rappdirs::user_config_dir("lmprompt", "R")
  keyfile <- file.path(config_dir, paste0(keyname, ".rds"))
  if (file.exists(keyfile)) {
    key <- readRDS(keyfile)
    cli::cli_inform("Keyfile read successfully.")
  } else {
    key <- NULL
    cli::cli_abort("Keyfile could not be found.")
  }
  key
}

#' Prompt OpenAI API
#'
#' Prompt local large language model from OpenAI using API.
#'
#' @param prompt A required string containing the prompt to give the LLM.
#' @param model A required string containing the model name in LMStudio.
#' @param context Either NULL or a string containing the system context to give
#'   the LLM (default = NULL).
#' @param key A string containing your API key. See `save_key()` and
#'   `load_key() for related convenience functions.
#' @param temperature A number representing how random vs. deterministic the
#'   output is. Set to 0 to always get the same response.
#' @return A string containing the LLM's response to your prompt.
#' @export
#' @examples
#' prompt_openai(
#'   prompt = "Introduce yourself.",
#'   model = "gpt-3.5-turbo-0125"
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
    httr2::request("http://api.openai.com/v1/chat/completions") |>
    httr2::req_headers(
      "Authorization" = paste("Bearer", key),
      "Content-Type" = "application/json"
    ) |>
    httr2::req_body_json(body_json) |>
    httr2::req_perform()

  httr2::resp_body_json(resp)$choices[[1]]$message$content
}
