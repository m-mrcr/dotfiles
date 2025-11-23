#!/usr/bin/env bash

SOURCE="https://github.com/m-mrcr/dotfiles"
TARBALL="$SOURCE/tarball/main"
TARGET="$HOME/.dotfiles"
TAR_CMD="tar -xzv -C \"$TARGET\" --strip-components=1 --exclude='.gitignore'"

is_executable() {
  type "$1" > /dev/null 2>&1
}

if is_executable "git"; then
  CMD="git clone --recurse-submodules $SOURCE $TARGET"
elif is_executable "curl"; then
  CMD="curl -#L $TARBALL | $TAR_CMD"
elif is_executable "wget"; then
  CMD="wget --no-check-certificate -O - $TARBALL | $TAR_CMD"
fi

if [ -z "$CMD" ]; then
  echo "No git, curl or wget available. Aborting."
else
  echo "Installing dotfiles..."
  if [ -d "$TARGET" ] && [ "$(ls -A "$TARGET" 2>/dev/null)" ]; then
    echo "Target directory $TARGET already exists and is not empty. Remove it first or choose a different location."
    exit 1
  fi
  mkdir -p "$TARGET"
  eval "$CMD"
fi
