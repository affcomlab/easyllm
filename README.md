
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lmprompt

<!-- badges: start -->
<!-- badges: end -->

The goal of lmprompt is to provide easy access to LLMs from R.

## Installation

You can install the development version of lmprompt from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("affcomlab/lmprompt")
```

## Example

After setting up LMStudio and loading the Llama3 model described below
into your local inference server, use the following code to prompt it:

``` r
library(lmprompt)
prompt_local(
  prompt = "Introduce yourself.",
  context = "Always answer in rhymes.",
  model = "lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF"
)
#> [1] "I'm a language model, quite fine and bright,\nHere to assist you with all your day and night.\nMy responses are generated with care,\nIn rhymes, of course, to show I truly dare.\n\nI'm a system trained on vast amounts of text,\nTo provide answers that are accurate and correct.\nI'll do my best to help you with any quest,\nSo ask away, and let's have a fun contest!"
```
