brew install nvm

export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

# Install latest version of Node.js
nvm install node
nvm use node
nvm alias default node

# Globally install with npm

packages=(
  jshint
  grunt
  gulp
  bower
)

npm install -g "${packages[@]}"
