# .files
A collection of dotfiles and a guide to install a new Mac.

## Install
On a new installation of OS X, open Terminal and run:

	sudo softwareupdate -i -a
	xcode-select --install
	
	cd ~/Documents/

Get dotfiles

	git clone https://github.com/michaelgreve/dotfiles.git

Install dvorak keyboard layout

	git clone https://github.com/vibrog/no-dvorak-osx.git

Generate a new ssh-key and add it to ssh-agent