
#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
BASHRC="$HOME/.bashrc"
GIT_ALIASES="$DOTFILES_DIR/git/aliases.gitconfig"

echo "Setting up dotfiles..."

# ----------------------------------------
# Dependencies: Starship
# ----------------------------------------

mkdir -p "$BIN_DIR"

if command -v starship >/dev/null 2>&1 ||
   [[ -x "$BIN_DIR/starship" ]]; then
    echo "✓ Starship already installed"
else
    if ! command -v curl >/dev/null 2>&1; then
        echo "✗ curl is required to install Starship"
        exit 1
    fi

    echo "Installing Starship..."

    installer="$(mktemp)"
    trap 'rm -f "$installer"' EXIT

    curl -fsSL https://starship.rs/install.sh \
        -o "$installer"

    sh "$installer" -b "$BIN_DIR" -y

    rm -f "$installer"
    trap - EXIT

    echo "✓ Starship installed"
fi

# ----------------------------------------
# Bash configuration
# ----------------------------------------

touch "$BASHRC"

if ! grep -Fq 'bash/interactive.sh' "$BASHRC"; then
    {
        printf '\n# Personal dotfiles\n'
        printf 'if [[ -f %q ]]; then\n' \
            "$DOTFILES_DIR/bash/interactive.sh"
        printf '    source %q\n' \
            "$DOTFILES_DIR/bash/interactive.sh"
        printf 'fi\n'
    } >> "$BASHRC"

    echo "✓ Bash configuration linked"
else
    echo "✓ Bash configuration already present"
fi

# ----------------------------------------
# Git configuration
# ----------------------------------------

if [[ ! -f "$GIT_ALIASES" ]]; then
    echo "✗ Git aliases file missing"
    exit 1
fi

if git config --global --get-all include.path |
   grep -Fxq "$GIT_ALIASES"; then
    echo "✓ Git aliases already included"
else
    git config --global --add include.path \
        "$GIT_ALIASES"

    echo "✓ Git aliases included"
fi

echo
echo "✓ Dotfiles setup complete!"
echo "Open a new terminal to activate changes."
