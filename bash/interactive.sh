
#!/usr/bin/env bash

# ---------------------------------------------
# Interactive Bash configuration
# ---------------------------------------------

# Disable history expansion (!)
set +H

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git
alias g='git'

# Visual Studio Code
alias c='code'

# File listing (GNU/Linux)
alias ll='ls -lah --group-directories-first --color=auto'


# ---------------------------------------------
# Starship prompt
# ---------------------------------------------

# Make locally installed tools available
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if command -v starship >/dev/null 2>&1; then
    # Locate the repository relative to this file
    if [[ -z "${STARSHIP_CONFIG:-}" ]]; then
        DOTFILES_ROOT="$(
            cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
        )"

        export STARSHIP_CONFIG="$DOTFILES_ROOT/starship/starship.toml"
        unset DOTFILES_ROOT
    fi

    eval "$(starship init bash)"
fi
