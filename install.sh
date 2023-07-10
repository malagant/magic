#!/bin/bash
set -x
set -e

FLOX_ENV_NAME=macos
PACKAGES_TO_INSTALL="git direnv zsh tmux neovim ripgrep rustup home-manager zellij zoxide alacritty iterm2 antibody"
HOME_NIX="$HOME/.config/home-manager/home.nix"

# Download and nstall flox binary
installFlox() {
	curl -o flox.aarch64-darwin.pkg 'https://floxdev.com/downloads/osx/flox.aarch64-darwin.pkg'
	open flox.aarch64-darwin.pkg
}

# Setup flox and all
setupFlox() {
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	flox create -e $FLOX_ENV_NAME || true
	flox install -e $FLOX_ENV_NAME "$PACKAGES_TO_INSTALL"
}

setupHomeManager() {
	if [ ! -f "$HOME_NIX" ]; then
		echo "home.nix not found, creating it"
		home-manager init
	fi
	home-manager switch
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
echo "Setting up home-manager"
setupHomeManager
echo "Installing rust"
installRust
