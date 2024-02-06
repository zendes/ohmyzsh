# goenv plugin

The primary job of this plugin is to provide `goenv_prompt_info` which can be added to your theme to include Golang
version information into your prompt.

To use it, add `goenv` to the plugins array in your zshrc file:

```zsh
plugins=(... goenv)
```

## Functions

* `goenv_prompt_info`: displays the Golang version in use by goenv; or the global Golang
  version, if goenv wasn't found. You can use this function in your prompt by adding
  `$(goenv_prompt_info)` to PROMPT or RPROMPT:

  ```zsh
  RPROMPT='$(goenv_prompt_info)'
  ```
