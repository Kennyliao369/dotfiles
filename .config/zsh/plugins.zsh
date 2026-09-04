_plugdir="/usr/share/zsh/plugins"

_load_plugin() {
local f="$_plugdir/$1/$1.zsh"
  [[ -r $f ]] && source "$f"
}

# zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi


# zsh-syntax-highlighting
_load_plugin zsh-syntax-highlighting
 
unfunction _load_plugin
unset _plugdir

