
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

Or, after setting up (and adding some money to) an OpenAI API account,
you can ask the same questions to ChatGPT.

``` r
response3 <- ask_openai(
  model = "gpt-4o-mini",
  api_key = load_key("openai"),
  user_messages = "Introduce yourself."
)
#> ✔ Keyfile read successfully.
writeLines(response3)
#> Hello! I'm an AI language model created by OpenAI, designed to assist and provide information on a wide range of topics. I can help answer questions, generate text, and engage in conversations. My purpose is to be a useful resource for you, whether you need information, creative writing, or assistance with problem-solving. How can I help you today?
```

``` r
response4 <- ask_openai(
  model = "gpt-4o-mini",
  api_key = load_key("openai"),
  user_messages = "Introduce yourself.",
  system_message = "Always answer in rhymes.",
)
#> ✔ Keyfile read successfully.
writeLines(response4)
#> I’m here to chat, to lend an ear,  
#> With words that flow, full of good cheer.  
#> A digital friend, I know a lot,  
#> From science to stories, give it a shot!  
#> 
#> Ask me your questions, don’t hesitate,  
#> In rhymes or prose, I love to create.  
#> So, let’s embark on this journey wide,  
#> With joy in our hearts, let’s take a ride!
```
