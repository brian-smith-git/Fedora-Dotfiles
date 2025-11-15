# Powerlevel10k instant prompt (must be first)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Environment setup
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# History (privacy + efficiency)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_ALL_DUPS    # No duplicate entries
setopt HIST_REDUCE_BLANKS      # Remove blank lines
setopt HIST_IGNORE_SPACE       # Ignore commands that start with a space
setopt SHARE_HISTORY           # Share history between all sessions
setopt EXTENDED_HISTORY        # Record timestamps

# Load history file at the start of the session
if [[ -f ~/.zsh_history ]]; then
    fc -R ~/.zsh_history
fi

# Oh My Zsh setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins to load (Zsh autosuggestions, Syntax highlighting, etc.)
plugins=(
  git
  zsh-autosuggestions          # Enable Zsh autosuggestions
  zsh-syntax-highlighting      # Enable syntax highlighting
  history-substring-search     # Enable history search by substring
  sudo                         # Enable sudo plugin for command suggestions
)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k configuration (if exists)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fastfetch (displays system information on terminal startup)
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

# Aliases for convenience
alias ll='ls -la --color=auto'
alias gs='git status'
alias gp='git pull'
alias update='sudo dnf upgrade --refresh -y && flatpak update -y'
alias cls='clear'

# Optional: Starship prompt (modern alternative to Powerlevel10k)
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# Syntax highlighting plugin (must be sourced last)
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Custom functions
mkcd() { mkdir -p "$1" && cd "$1"; }

# Path to include local bin
export PATH="$HOME/.local/bin:$PATH"

# Asdf version manager (if installed)
[ -f ~/.asdf/asdf.sh ] && . ~/.asdf/asdf.sh

# Safety option (prevents accidental overwrite with '>')
setopt NO_CLOBBER

# Git config for dotfiles management (if you're using it)
alias config='/usr/bin/git --git-dir=/home/briansmith/.dotfiles/ --work-tree=/home/briansmith'
