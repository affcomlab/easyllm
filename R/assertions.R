is_between <- function(x, low, high) {
  x >= low && x <= high
}

is_null_or_between <- function(x, low, high) {
  is.null(x) || is_between(x, low, high)
}

has_length <- function(x, n) {
  ifelse(is.null(n), TRUE, length(x) == n)
}

is_string <- function(x, n = NULL) {
  is.character(x) && has_length(x, n)
}

is_number <- function(x, n = NULL) {
  is.numeric(x) && has_length(x, n)
}

is_integer <- function(x, n = NULL) {
  (floor(x) == ceiling(x)) && has_length(x, n)
}

is_logical <- function(x, n = NULL) {
  is.logical(x) && has_length(x, n)
}

is_null_or_string <- function(x, n = NULL) {
  is.null(x) || is_string(x, n)
}

is_null_or_number <- function(x, n = NULL) {
  is.null(x) || is_number(x, n)
}

is_null_or_integer <- function(x, n = NULL) {
  is.null(x) || is_integer(x, n)
}
