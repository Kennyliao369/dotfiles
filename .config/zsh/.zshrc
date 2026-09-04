# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}" # Auto create dir

HISTSIZE=50000
SAVEHIST=50000
HISTORY_IGNORE='(ls|ll|la|cd|cd ..|pwd|exit|clear|reboot|poweroff)'

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Behavior
setopt NO_BEEP
setopt AUTO_CD
setopt NUMERIC_GLOB_SORT

# Completion
_cachedir="$XDG_CACHE_HOME/zsh"
[[ -d ${_cachedir} ]] || mkdir -p "$_cachedir" # Auto create dir

autoload -Uz compinit
compinit -d "$_cachedir/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$_cachedir/zcompcache"

unset _cachedir

# yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
} 

# Config file
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/bindings.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/prompt.zsh"
