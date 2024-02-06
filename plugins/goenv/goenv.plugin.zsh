# This plugin loads goenv into the current shell and provides prompt info via
# the 'goenv_prompt_info' function.

FOUND_GOENV=${+commands[goenv]}

if [[ $FOUND_GOENV -ne 1 ]]; then
  goenvdirs=(
    "$HOME/.goenv"
    "/opt/homebrew/opt/goenv"
    "/usr/local/opt/goenv"
  )
  for dir in $goenvdirs; do
    if [[ -d "${dir}/bin" ]]; then
      export PATH="$PATH:${dir}/bin"
      FOUND_GOENV=1
      break
    fi
  done

  if [[ $FOUND_GOENV -ne 1 ]]; then
    if (( $+commands[brew] )) && dir=$(brew --prefix goenv 2>/dev/null); then
      if [[ -d "${dir}/bin" ]]; then
        export PATH="$PATH:${dir}/bin"
        FOUND_GOENV=1
      fi
    fi
  fi
fi

if [[ $FOUND_GOENV -eq 1 ]]; then
  eval "$(goenv init --no-rehash - zsh)"
  function goenv_prompt_info() {
    goenv version-name 2>/dev/null
  }
else
  # fallback to system node
  function goenv_prompt_info() {
    # go version -> go version go1.21.6 darwin/arm64
    echo "system: $(go version 2>&1 | cut -d " " -f 3 | cut -c 3-)"
  }
fi

unset FOUND_GOENV goenvdirs dir
