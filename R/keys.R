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
    cli::cli_alert_success("Keyfile updated.")
  } else {
    if (!dir.exists(config_dir)) dir.create(config_dir, recursive = TRUE)
    saveRDS(key, keyfile)
    cli::cli_alert_success("Keyfile created.")
  }
}

#' Load an API key
#'
#' Load an API key string from a config file created by `save_key()`.
#'
#' @param keyname An optional string containing the name of the key to load.
#'   (default = "key")
#' @param quietly An optional logical indicating whether to suppress the
#'   successfully loaded message. (default = FALSE)
#' @return A string containing the loaded key.
#' @export
#' @examples
#' key <- load_key("openai")
#'
load_key <- function(keyname = "key", quietly = FALSE) {
  config_dir <- rappdirs::user_config_dir("lmprompt", "R")
  keyfile <- file.path(config_dir, paste0(keyname, ".rds"))
  if (file.exists(keyfile)) {
    key <- readRDS(keyfile)
    if (quietly == FALSE) {
      cli::cli_alert_success("Keyfile read successfully.")
    }
  } else {
    key <- NULL
    cli::cli_abort("No keys with that name were found.")
  }
  key
}

#' Find all saved API keys
#'
#' Find the names of all API keys that have been saved using `save_key()` so
#' that they can be loaded using `load_key()` or removed using `remove_key()`.
#'
#' @return A character vector containing all API keys found.
#' @export
#' @examples
#' find_keys()
#'
find_keys <- function() {
  config_dir <- rappdirs::user_config_dir("lmprompt", "R")
  keyfiles <- list.files(config_dir, ".rds$")
  tools::file_path_sans_ext(keyfiles)
}

#' Remove a saved API key
#'
#' Delete from your computer the API key stored under `name`. Find all stored
#' API keys using `find_keys()`.
#'
#' @param keyname A string containing the name of the key to remove.
#' @export
#' @examples
#' remove_key("openai")
#'
remove_key <- function(keyname) {
  config_dir <- rappdirs::user_config_dir("lmprompt", "R")
  keyfile <- file.path(config_dir, paste0(keyname, ".rds"))
  if (file.exists(keyfile)) {
    file.remove(keyfile)
    cli::cli_alert_success("Key successfully removed.")
  } else {
    cli::cli_abort("No keys with that name were found.")
  }
}
