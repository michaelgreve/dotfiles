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

)



### Install Casks

apps=(
	bettertouchtools
	dash
	dropbox
	flux
	google-chrome
	google-chrome-canary
	google-drive
	sublime-text
	vlc
)
