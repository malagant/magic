#!/bin/bash
set -x
set -e
# Download and nstall flox binary
installFlox() {
	curl -o flox.aarch64-darwin.pkg 'https://floxdev.com/downloads/osx/flox.aarch64-darwin.pkg'
	open flox.aarch64-darwin.pkg
}

if ! command -v flox &>/dev/null; then
	echo "flox could not be found, installing it"
	installFlox
else
	echo "flox is already installed. Skipping installation"
fi
