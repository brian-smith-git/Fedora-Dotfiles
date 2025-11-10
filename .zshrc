# -------------------------------------------------
# Zsh configuration for briansmith (Fedora 43)
# -------------------------------------------------

# --- Powerlevel10k instant prompt (must be first) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Environment ---
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# --- History (privacy + efficiency) ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  history-substring-search
  sudo
)

source $ZSH/oh-my-zsh.sh

# --- Fastfetch on terminal startup ---
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

# --- Aliases ---
alias ll='ls -la --color=auto'
alias gs='git status'
alias gp='git pull'
alias update='sudo dnf upgrade --refresh -y && flatpak update -y'
alias cls='clear'

# --- Starship prompt (optional, modern replacement for P10K) ---
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# --- Source syntax highlighting last ---
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# -------------------------------------------------
# Zsh configuration for briansmith (Fedora 42)
# -------------------------------------------------

# --- Powerlevel10k instant prompt (must be first) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Environment ---
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# --- History (privacy + efficiency) ---
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS   # no duplicate history entries
setopt HIST_REDUCE_BLANKS     # remove superfluous blanks
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt SHARE_HISTORY          # share history across sessions
setopt EXTENDED_HISTORY       # record timestamp of commands

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  history-substring-search
)

# Fastfetch on terminal startup
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

source $ZSH/oh-my-zsh.sh

# Syntax highlighting MUST be sourced last
source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Powerlevel10k config ---
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Aliases ---
alias ll="ls -lh --color=auto"
alias la="ls -lha --color=auto"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias v="nvim"
alias update="sudo dnf update -y && flatpak update -y"

# --- Path additions ---
export PATH="$HOME/.local/bin:$PATH"

# --- Asdf version manager (if installed) ---
[ -f ~/.asdf/asdf.sh ] && . ~/.asdf/asdf.sh

# --- Custom functions ---
mkcd() { mkdir -p "$1" && cd "$1"; }

# --- Safety ---
setopt NO_CLOBBER   # prevent accidental overwrite with >
alias config='/usr/bin/git --git-dir=/home/briansmith/.dotfiles/ --work-tree=/home/briansmith'

