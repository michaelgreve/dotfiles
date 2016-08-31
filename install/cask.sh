#!/usr/bin/env bash

# Tapping
brew tap Caskroom/versions

### Install Casks

apps=(
	iterm
	bettertouchtool
	dash
	dropbox
	flux
	google-chrome
	google-chrome-canary
	google-drive
	sublime-text
	vlc
)

brew cask install "${apps[@]}"
unset apps