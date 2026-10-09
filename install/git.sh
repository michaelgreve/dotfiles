#!/usr/bin/env bash

install_git() {
    local config="$DOTFILES_DIR/git/aliases.gitconfig"
    local includes

    echo
    echo "Git:"

    if ! command -v git >/dev/null 2>&1; then
        echo "✗ Git is not installed" >&2
        return 1
    fi

    if [[ ! -f "$config" ]]; then
        echo "✗ Git aliases missing: $config" >&2
        return 1
    fi

    includes="$(
        git config --global --get-all include.path 2>/dev/null || true
    )"

    if grep -Fxq "$config" <<< "$includes"; then
        echo "✓ Git aliases already configured"
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "→ Would include $config in global Git config"
        return 0
    fi

    git config --global --add include.path "$config"

    echo "✓ Git aliases configured"
}
