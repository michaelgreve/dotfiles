#!/usr/bin/env bash

install_shell() {
    local bashrc="$HOME/.bashrc"
    local config="$DOTFILES_DIR/bash/interactive.sh"

    echo
    echo "Shell:"

    if [[ ! -f "$config" ]]; then
        echo "✗ Bash configuration missing: $config" >&2
        return 1
    fi

    # Recognize our existing manual installation.
    if [[ -f "$bashrc" ]] &&
       grep -Fq 'bash/interactive.sh' "$bashrc"; then
        echo "✓ Bash already configured"
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "→ Would add dotfiles loader to $bashrc"
        return 0
    fi

    touch "$bashrc"

    {
        printf '\n# Personal dotfiles\n'
        printf 'if [[ -f %q ]]; then\n' "$config"
        printf '    source %q\n' "$config"
        printf 'fi\n'
    } >> "$bashrc"

    echo "✓ Bash configuration linked"
}
