#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false

# Command-line options
while (($# > 0)); do
    case "$1" in
        --dry-run)
            DRY_RUN=true
            ;;
        -h|--help)
            cat <<'EOF'
Dotfiles installer

Usage: ./install.sh [options]

Options:
  --dry-run   Show planned changes without applying them
  -h, --help  Show this help
EOF
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
    esac
    shift
done

echo "Dotfiles 2.0"
echo "-------------"

if [[ "$DRY_RUN" == true ]]; then
    echo "Dry run: no changes will be made"
fi

# Load installation modules
source "$DOTFILES_DIR/install/packages.sh"
source "$DOTFILES_DIR/install/shell.sh"
source "$DOTFILES_DIR/install/git.sh"

# Run installation steps
install_packages
install_shell
install_git

echo
echo "✓ Setup complete!"

if [[ "$DRY_RUN" == false ]]; then
    echo "Open a new terminal to activate shell changes."
fi
