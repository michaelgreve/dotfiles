#!/usr/bin/env bash

### Install Brews

# Install command-line tools using Homebrew.

# Check if Homebrew is already installed
if ! which brew > /dev/null; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

# Make sure we’re using the latest Homebrew.
brew update

# Tap casks
brew tap homebrew/versions
brew tap homebrew/dupes

# Upgrade any already-installed formulae.
brew upgrade --all

apps=(
	bash
	bash-completion2
	curl --with-openssl --with-libssh2
	moreutils
	composer
	htop
	gnu-sed --with-default-names
	grep --with-default-names
	findutils --with-default-names
	git --with-brewed-curl --with-brewed-openssl
	dockutil
	wget --with-iri
	wifi-password
	vim --with-override-system-vi
	homebrew/dupes/openssh
	homebrew/dupes/screen
	homebrew/php/php56 --with-mssql --with-homebrew-curl --with-homebrew-libxml2 --with-pear
)
brew install "${apps[@]}"
unset apps

# Add coreutils to path
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;