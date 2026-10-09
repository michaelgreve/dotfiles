#!/usr/bin/env bash

install_starship() {
    local bin_dir="$HOME/.local/bin"

    if command -v starship >/dev/null 2>&1 ||
       [[ -x "$bin_dir/starship" ]]; then
        echo "✓ Starship already installed"
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "→ Would install Starship into $bin_dir"
        return 0
    fi

    if ! command -v curl >/dev/null 2>&1; then
        echo "✗ curl is required to install Starship" >&2
        return 1
    fi

    mkdir -p "$bin_dir"

    echo "→ Installing Starship..."

    local installer
    installer="$(mktemp)"

    if ! curl -fsSL \
        https://starship.rs/install.sh \
        -o "$installer"; then
        rm -f "$installer"
        return 1
    fi

    if ! sh "$installer" -b "$bin_dir" -y; then
        rm -f "$installer"
        return 1
    fi

    rm -f "$installer"

    echo "✓ Starship installed"
}

install_packages() {
    local manifest="$DOTFILES_DIR/packages/common.txt"
    local package

    if [[ ! -f "$manifest" ]]; then
        echo "✗ Package manifest missing: $manifest" >&2
        return 1
    fi

    echo
    echo "Packages:"

    while IFS= read -r package || [[ -n "$package" ]]; do
        case "$package" in
            ""|\#*) continue ;;
            starship) install_starship ;;
            *)
                echo "✗ Unknown package: $package" >&2
                return 1
                ;;
        esac
    done < "$manifest"
}
