#' Prompt Local LLM
#'
#' Prompt local large language model from LMStudio
#'
#' @param prompt A string containing the prompt to give the LLM.
#' @param context A string containing the system context to give the LLM.
#' @param model A string containing the model name in LMStudio.
#' @param port A number or string containing the port number set in LMStudio
#'   (default = 1234).
#' @param temperature A number representing how random vs. deterministic the
#'   output is. Set to 0 to always get the same response.
#' @return A string containing the LLM's response to your prompt.
#' @export
#' @examples
#' prompt_local("Introduce yourself.", "Always answer in rhymes.", "lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF")
prompt_local <- function(prompt, context, model, port = 1234, temperature = 0) {
  resp <-
    httr2::request(paste0("http://localhost:", port, "/v1/chat/completions")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_body_json(
      list(
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
    ) |>
    httr2::req_perform()

  httr2::resp_body_json(resp)$choices[[1]]$message$content
}
