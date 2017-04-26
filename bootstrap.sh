#!/usr/bin/env bash

# Check for source command
if [ $(type -P source) ]; then
    source='source'
else
    source='.'
fi

# Ask for administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

### Setting directories
# DOTFILES_DIRECTORY="${HOME}/.dotfiles"
# DOTFILES_TARBALL_PATH="https://github.com/michaelgreve/dotfiles/tarball/master"
# DOTFILES_GIT_REMOTE="git@github.com:michaelgreve/dotfiles.git"

# If missing, download and extract the dotfiles repository
# if [[ ! -d ${DOTFILES_DIRECTORY} ]]; then
#     printf "$(tput setaf 7)Downloading dotfiles...\033[m\n"
#     mkdir ${DOTFILES_DIRECTORY}
#     # Get the tarball
#     curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOTFILES_TARBALL_PATH}
#     # Extract to the dotfiles directory
#     tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOTFILES_DIRECTORY}
#     # Remove the tarball
#     rm -rf ${HOME}/dotfiles.tar.gz
# fi

# cd ${DOTFILES_DIRECTORY}

### Load utils file
$source ./default/lib/help
$source ./default/lib/utils
$source ./default/shell/aliases
$source ./lib/npm

if is_mac; then
    $source ./macos/lib/brew
    $source ./macos/lib/cask
    $source ./macos/shell/aliases
fi

# source ./lib/brew
# source ./lib/cask
# source ./lib/npm

# # Help text
# if [[ "$1" == "-h" || "$1" == "--help" ]]; then
#     run_help
#     exit
# fi

# # Test for known flags
# for opt in $@
# do
#     case $opt in
#         --no-packages) no_packages=true ;;
#         --no-sync) no_sync=true ;;
#         -*|--*) e_warning "Warning: invalid option $opt" ;;
#     esac
# done

# # Before relying on Homebrew, check that packages can be compiled
# if ! type_exists 'gcc'; then
#     e_warning "The XCode Command Line Tools must be installed first."
#     e_header "Installing XCode"
#     xcode-select --install &> /dev/null

#     # Wait until XCode is installed
# 	until xcode-select --print-path &> /dev/null; do
#     	sleep 5
# 	done

# 	# Point XCode to the appropriate directory
# 	sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

# 	# Prompt user to agree to the terms
# 	sudo xcodebuild -license
# fi

# # Check for Homebrew
# if ! type_exists 'brew'; then
# 	e_header "Homebrew is not installed, getting latest version ..."
# 	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# 	[[ $? ]] && e_success "Homebrew installed"
# fi

# # Check for git
# if ! type_exists 'git'; then
#     e_header "Updating Homebrew ..."
#     brew update
#     e_header "Installing Git ..."
#     brew install git
# fi

# # Initialize the git repository if it's missing
# if ! is_git_repo; then
#     e_header "Initializing git repository ..."
#     git init
#     git remote add origin ${DOTFILES_GIT_REMOTE}
#     git fetch origin master
#     # Reset the index and working tree to the fetched HEAD
#     # (submodules are cloned in the subsequent sync step)
#     git reset --hard FETCH_HEAD
#     # Remove any untracked files
#     git clean -fd
# fi

# # Conditionally sync with the remote repository
# if [[ $no_sync ]]; then
#     printf "Skipped dotfiles sync.\n"
# else
#     e_header "Syncing dotfiles ..."
#     # Pull down the latest changes
#     git pull --rebase origin master
#     # Update submodules
#     git submodule update --recursive --init --quiet
# fi

# # Install and update packages
# if [[ $no_packages ]]; then
#     printf "Skipped package installations.\n"
# else
#     printf "Updating packages ...\n"
#     # Install Homebrew formulae
#     run_brew
#     # Install Node packages
#     run_npm
# fi

# link() {
#     # Force create/replace the symlink.
#     ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
# }

# mirrorfiles() {
#     # Copy `.gitconfig`.
#     # Any global git commands in `~/.bash_profile.local` will be written to
#     # `.gitconfig`. This prevents them being committed to the repository.
#     rsync -avz --quiet ${DOTFILES_DIRECTORY}/git/gitconfig  ${HOME}/.gitconfig

#     # Force remove the vim directory if it's already there.
#     if [ -e "${HOME}/.vim" ]; then
#         rm -rf "${HOME}/.vim"
#     fi

#     # Create the necessary symbolic links between the `.dotfiles` and `HOME`
#     # directory. The `bash_profile` sources other files directly from the
#     # `.dotfiles` repository.
#     link "shell/bashrc"       ".bashrc"
#     link "shell/bash_profile" ".bash_profile"
#     link "shell/curlrc"       ".curlrc"
#     link "shell/inputrc"      ".inputrc"
#     # link "vim"                ".vim"
#     # link "vim/vimrc"          ".vimrc"

#     e_success "Dotfiles update complete!"
# }

# ### Set computer name
# e_header "Current computer name: $(scutil --get ComputerName)"
# read -p "Do you want to change the name for your computer? " -n 1
# if [[ "$REPLY" =~ ^[Yy]$ ]]; then

# 	e_header "Enter the name you want for your computer:"
# 	read computername

# 	if [[ -z $computername ]]; then
# 		e_warning "No name give, continuing script ..."
# 	else
# 		sudo scutil --set ComputerName "$computername"
# 		sudo scutil --set HostName "$computername"
# 		sudo scutil --set LocalHostName "$computername"
# 		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computername"
#         e_success "Name changed"
# 	fi
# fi

# # Ask before potentially overwriting files
# seek_confirmation "Warning: This step may overwrite your existing dotfiles."

# if is_confirmed; then
#     mirrorfiles
#     source ${HOME}/.bash_profile
# else
#     printf "Aborting...\n"
#     exit 1
# fi

# # Ask before potentially overwriting OS X defaults
# seek_confirmation "Warning: This step may modify your OS X system defaults."

# if is_confirmed; then
#     bash ./bin/osxdefaults
#     e_success "OS X settings updated! You may need to restart."
# else
#     printf "Skipped OS X settings update.\n"
# fi
