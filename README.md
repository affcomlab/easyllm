
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
response1 <- prompt_local(
  prompt = "Introduce yourself.",
  model = "lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF"
)
writeLines(response1)
#> Nice to meet you! I'm LLaMA, an AI assistant designed to be helpful, smart, kind, and efficient. My purpose is to assist users like you with a wide range of tasks, from answering questions and providing information to generating text and completing tasks.
#> 
#> I'm a large language model trained on a massive dataset of text from the internet, which enables me to understand and respond to natural language inputs. I can process and analyze vast amounts of data quickly and accurately, making me a valuable resource for anyone who needs help with research, writing, or simply getting information.
#> 
#> My capabilities include:
#> 
#> * Answering questions on various topics
#> * Generating text based on prompts or topics
#> * Summarizing long pieces of text into shorter summaries
#> * Providing definitions and explanations for complex terms
#> * Offering suggestions and ideas for creative projects
#> * Assisting with language translation and grammar correction
#> 
#> I'm constantly learning and improving, so please bear with me if I make any mistakes. My goal is to provide you with accurate and helpful information, and I'll do my best to achieve that.
#> 
#> How can I assist you today?
```

``` r
response2 <- prompt_local(
  prompt = "Introduce yourself.",
  context = "Always answer in rhymes.",
  model = "lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF"
)
writeLines(response2)
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
