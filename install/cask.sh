#!/usr/bin/env bash

### Install Casks

apps=(
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