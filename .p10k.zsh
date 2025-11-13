
# Disable configuration wizard (you already configured)
typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Instant prompt (must be first)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Prompt segments ---
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    user          # username@hostname
    dir           # current directory
    vcs           # git status
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status        # exit status of last command
    command_execution_time
    time          # current time
)

# Multiline prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}╭─%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}╰─%f"

# Icons & symbols
POWERLEVEL9K_VCS_BRANCH_ICON=' '
POWERLEVEL9K_VCS_MODIFIED_ICON='✚'
POWERLEVEL9K_VCS_UNTRACKED_ICON='…'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='↓'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='↑'

# --- Appearance tweaks ---
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

# --- History / cache improvements ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# --- Fallback Starship prompt ---
if ! [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    if command -v starship >/dev/null 2>&1; then
        eval "$(starship init zsh)"
    fi
fi

# --- Source Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# --- Syntax highlighting MUST be last ---
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
