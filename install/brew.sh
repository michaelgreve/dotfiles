#!/usr/bin/env bash

### Install Brews

# Install command-line tools using Homebrew.

# Check if Homebrew is already installed
if ! which brew > /dev/null; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

apps=(
	bash-completion2
	gnu-sed --with-default-names
	grep --with-default-names
	git
	dockutil
	wget --with-iri
	wifi-password
)
brew install "${apps[@]}"
unset apps