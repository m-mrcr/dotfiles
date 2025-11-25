# If not running interactively, don't do anything

[[ $- != *i* ]] && return

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $0)
CURRENT_SCRIPT=${(%):-%N}

if [[ -n $CURRENT_SCRIPT && -x readlink ]]; then
  SCRIPT_PATH=$(readlink -n $CURRENT_SCRIPT)
  DOTFILES_DIR="${PWD}/$(dirname $(dirname $SCRIPT_PATH))"
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Make utilities available

PATH="$DOTFILES_DIR/bin:$PATH"

# Source the dotfiles (order matters)
# Note: .prompt is Bash-specific and not needed for Zsh (using Starship instead)

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,n,path,env,exports,alias,fzf,grep,completion,fix,zoxide}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

if is-macos; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function}.macos; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
  done
fi

# Set LSCOLORS (use gdircolors if available, fallback to dircolors)

if command -v gdircolors >/dev/null 2>&1; then
  eval "$(gdircolors -b "$DOTFILES_DIR"/system/.dir_colors)"
elif command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b "$DOTFILES_DIR"/system/.dir_colors)"
fi

# Wrap up

unset CURRENT_SCRIPT SCRIPT_PATH DOTFILE
export DOTFILES_DIR

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [ -f "/opt/anaconda3/bin/conda" ]; then
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/opt/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/opt/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
fi
# <<< conda initialize <<<

eval "$(starship init zsh)"

