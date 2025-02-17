#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-git.sh
##  Desc:  Install Git and Git LFS
################################################################################

source ~/utils/utils.sh

echo "Installing Git..."
#brew_smart_install "git"

COMMIT=aecf26f53d0d1d15d42f658ae2db243f87746af6
FORMULA_URL="https://raw.githubusercontent.com/Homebrew/homebrew-core/$COMMIT/Formula/g/git.rb"
FORMULA_PATH="$(brew --repository)/Library/Taps/homebrew/homebrew-core/Formula/g/git.rb"
mkdir -p "$(dirname $FORMULA_PATH)"
curl -fsSL $FORMULA_URL -o $FORMULA_PATH
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew install git

git config --global --add safe.directory "*"

echo "Installing Git LFS"
brew_smart_install "git-lfs"

# Update global git config
git lfs install
# Update system git config
sudo git lfs install --system

echo "Disable all the Git help messages..."
git config --global advice.pushUpdateRejected false
git config --global advice.pushNonFFCurrent false
git config --global advice.pushNonFFMatching false
git config --global advice.pushAlreadyExists false
git config --global advice.pushFetchFirst false
git config --global advice.pushNeedsForce false
git config --global advice.statusHints false
git config --global advice.statusUoption false
git config --global advice.commitBeforeMerge false
git config --global advice.resolveConflict false
git config --global advice.implicitIdentity false
git config --global advice.detachedHead false
git config --global advice.amWorkDir false
git config --global advice.rmHints false

invoke_tests "Git"
