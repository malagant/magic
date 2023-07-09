#!/bin/bash
set -x
set -e

FLOX_ENV_NAME=macos
PACKAGES_TO_INSTALL="git zsh tmux neovim ripgrep rustup home-manager zellij"
# Download and nstall flox binary
installFlox() {
	curl -o flox.aarch64-darwin.pkg 'https://floxdev.com/downloads/osx/flox.aarch64-darwin.pkg'
	open flox.aarch64-darwin.pkg
}

# Setup flox and all
setupFlox() {
	flox create -e $FLOX_ENV_NAME || true
	flox install -e $FLOX_ENV_NAME "$PACKAGES_TO_INSTALL"
}

activateEnvironment() {
	flox activate -e $FLOX_ENV_NAME
}

installRust() {
	rustup install stable
}

if ! command -v flox &>/dev/null; then
	echo "flox could not be found, installing it"
	installFlox
	setupFlox
else
	echo "flox is already installed. Skipping installation"
	setupFlox
	activateEnvironment
fi
echo "Installing rust"
installRust
