% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ask.R
\name{ask_openai}
\alias{ask_openai}
\title{Ask OpenAI}
\usage{
ask_openai(
  model,
  api_key,
  user_messages,
  system_message = NULL,
  assistant_messages = NULL,
  frequency_penalty = NULL,
  max_tokens = NULL,
  presence_penalty = NULL,
  seed = NULL,
  temperature = NULL,
  top_p = NULL,
  simplify = TRUE
)
}
\arguments{
\item{model}{(required string) ID of the model to use.}

\item{api_key}{(required string) containing your OpenAI API key. See
\code{save_key()} and \code{load_key()} for related convenience functions.}

\item{user_messages}{(required character vector) The user messages provide
requests or comments for the assistant to respond to. Note that, even when
providing multiple user messages, the assistant will only respond once.}

\item{system_message}{(string or NULL) The system message is optional and can
be used to set the behavior of the assistant.}

\item{assistant_messages}{(character vector or NULL) Assistant messages store
previous assistant responses, but can also be written by you to give
examples of desired behavior (few-shot examples).}

\item{frequency_penalty}{(number or NULL) Number between -2.0 and 2.0.
Positive values penalize new tokens based on their existing frequency in
the text so far, decreasing the model's likelihood to repeat the same line
verbatim.}

\item{max_tokens}{(integer or NULL) The maximum number of tokens that can be
generated in the chat completion. The total length of input tokens and
generated tokens is limited by the model's context length.}

\item{presence_penalty}{(number or NULL) Number between -2.0 and 2.0.
Positive values penalize new tokens based on whether they appear in the
text so far, increasing the model's likelihood to talk about new topics.}

\item{seed}{(integer or NULL) This feature is in Beta. If specified, the
system will make a best effort to sample deterministically, such that
repeated requests with the same seed and parameters should return the same
result. Determinism is not guaranteed.}

\item{temperature}{(number or NULL) What sampling temperature to use, between
0 and 2. Higher values likes 0.8 will make the output more random, while
lower values like 0.2 will make it more focused and deterministic. We
generally recommend altering this or \code{top_p} but not both.}

\item{top_p}{(number or NULL) An alternative to sampling with temperature,
called nucleus sampling, where the model considers the results of the
tokens with top_p probability mass. So 0.1 means only the tokens comprising
the top 10\% of probability mass are considered. We generally recommend
altering this or \code{temperature} but not both.}

\item{simplify}{(logical) Whether to return only the assistant's response as
a string or the full list object with full response details.}
}
\value{
Depending on \code{simplify}, either a string containing the assistant's
response (default) or a list object containing the full response details.
}
\description{
Ask a large language model from OpenAI (e.g., ChatGPT) using API.
}
\examples{
\dontrun{
ask_openai(
  model = "gpt-4o-mini",
  user_messages = "Introduce yourself.",
  system_message = "Always answer in rhymes.",
  api_key = load_key()
)
}
}
\references{
\url{https://platform.openai.com/docs/api-reference/chat/create}
}
