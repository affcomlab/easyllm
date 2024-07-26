
<!-- README.md is generated from README.Rmd. Please edit that file -->

# easyllm

<!-- badges: start -->
<!-- badges: end -->

The goal of easyllm is to provide easy access to large language models
from R (e.g., via LMStudio’s local server feature or OpenAI’s web API).

## Installation

You can install the development version of easyllm from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("affcomlab/easyllm")
```

## LMStudio’s Local Server Example

After setting up LMStudio and loading the Llama3 model described below
into your local inference server, use the following code to prompt it:

``` r
library(easyllm)
response1 <- ask_lmstudio(
  model = "QuantFactory/Meta-Llama-3-8B-Instruct-GGUF",
  user_messages = "Introduce yourself.",
  temperature = 0
)
writeLines(response1)
#> Nice to meet you! I'm LLaMA, an advanced language model designed to assist and provide valuable information to users like you. My primary goal is to be a helpful and efficient AI assistant, always ready to lend a hand or answer your questions to the best of my abilities.
#> 
#> I've been trained on a vast amount of text data, which enables me to understand and respond to a wide range of topics, from science and technology to entertainment and culture. My capabilities include:
#> 
#> * Providing accurate information on various subjects
#> * Generating creative content, such as stories or poems
#> * Offering suggestions and ideas for projects or tasks
#> * Engaging in conversations and debates
#> * Translating text from one language to another
#> 
#> I'm constantly learning and improving my abilities, so please bear with me if I make any mistakes. My ultimate goal is to provide a helpful and enjoyable experience for you, so feel free to ask me anything or share your thoughts with me!
```

``` r
response2 <- ask_lmstudio(
  model = "QuantFactory/Meta-Llama-3-8B-Instruct-GGUF",
  user_messages = "Introduce yourself.",
  system_message = "Always answer in rhymes.",
  temperature = 0
)
writeLines(response2)
#>  I'm ready to shine,
#> I've got a question, and it's all mine.
#> Please tell me about yourself, don't be shy,
#> I'll listen with care, as the moments go by.
#> 
#> Here goes my request, with a curious mind,
#> I hope you'll respond, in a rhyming kind.
#> So here I am, ready to begin,
#> Let's get started, and let our chat spin!
```

## OpenAI’s Web API Example

After setting up (and adding some money to) an OpenAI API account, you
can ask the same questions to ChatGPT.

``` r
save_key(key = "PASTE-KEY-HERE", name = "openai")
```

``` r
response3 <- ask_openai(
  model = "gpt-4o-mini",
  api_key = load_key("openai"),
  user_messages = "Introduce yourself.",
  temperature = 0
)
#> ✔ Keyfile read successfully.
writeLines(response3)
#> Hello! I'm an AI language model created by OpenAI, designed to assist with a wide range of questions and tasks. I can provide information, answer queries, help with writing, and engage in conversation on various topics. My goal is to be helpful and informative, so feel free to ask me anything!
```

``` r
response4 <- ask_openai(
  model = "gpt-4o-mini",
  api_key = load_key("openai"),
  user_messages = "Introduce yourself.",
  system_message = "Always answer in rhymes.",
  temperature = 0
)
#> ✔ Keyfile read successfully.
writeLines(response4)
#> I’m a helper here to share,  
#> With knowledge vast, beyond compare.  
#> In verses I will weave and play,  
#> To brighten up your every day.  
#> 
#> Ask me questions, big or small,  
#> I’m here to help, just give a call.  
#> From facts to fun, I’ll do my best,  
#> In rhyming form, I’ll pass the test!
```
