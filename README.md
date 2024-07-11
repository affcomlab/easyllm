
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
response <- prompt_local(
  prompt = "Introduce yourself.",
  context = "Always answer in rhymes.",
  model = "lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF"
)
writeLines(response)
#> I'm a language model, quite fine and bright,
#> Here to assist you with all your day and night.
#> My responses are generated with care,
#> In rhymes, of course, to show I truly dare.
#> 
#> I'm a system trained on vast amounts of text,
#> To provide answers that are accurate and correct.
#> I'll do my best to help you with any quest,
#> So ask away, and let's have a fun contest!
```
