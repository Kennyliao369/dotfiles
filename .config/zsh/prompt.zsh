setopt PROMPT_SUBST
autoload -Uz add-zsh-hook

# ssh info
typeset -g _host_info=''

[[ -n $SSH_CONNECTION ]] && _host_info='%F{108}%m%f:'

# git ststus
typeset -g _git_info=''

_git_prompt() {
  emulate -L zsh
  _git_info=''

  local raw
  raw=$(git status --porcelain=v2 --branch 2>/dev/null) || return 0

  local branch='' oid='' ab='' x='' y='' line
  local -i ahead=0 behind=0 staged=0 modified=0 untracked=0 conflict=0

  for line in ${(f)raw}; do
    case $line in
      '# branch.oid '*)
        oid=${line#'# branch.oid '} ;;

      '# branch.head '*)
        branch=${${line#'# branch.head '}//\%/%%} ;;

      '# branch.ab '*)
        ab=${line#'# branch.ab '}
        ahead=${${ab%% *}#+}
        behind=${${ab##* }#-}
        ;;

      [12]' '*)
        x=$line[3] y=$line[4]
        [[ $x != '.' ]] && (( staged++ ))
        [[ $y != '.' ]] && (( modified++ ))
        ;;

      'u '*) (( conflict++ )) ;;
      '? '*) (( untracked++ )) ;;
      esac
  done

  branch=${branch//'%'/%%}
  [[ $branch == '(detached)' ]] && branch="%F{red}${oid[1,7]}%f"

  local -a flags
  (( staged    )) && flags+="%F{green}+$staged%f"      # 已 staged
  (( modified  )) && flags+="%F{yellow}!$modified%f"   # 已修改未 staged
  (( untracked )) && flags+="%F{blue}?$untracked%f"    # 未追蹤
  (( conflict  )) && flags+="%F{red}✖$conflict%f"      # 衝突
  (( ahead     )) && flags+="%F{magenta}⇡$ahead%f"     # 領先上游
  (( behind    )) && flags+="%F{cyan}⇣$behind%f"       # 落後上游
  (( $#flags )) || flags=( "%F{green}✔%f" )            # 全乾淨

  _git_info="%F{244}⎇%f %F{140}$branch%f %F{244}[%f${(j: :)flags}%F{244}]%f"
  return 0    
}

# Auto start
add-zsh-hook precmd _git_prompt

# Prompt
PROMPT='%F{244}[%f${_host_info}%(!.%F{red}.%F{110})%n%f%F{244}]%f %F{140}%(5~|%-1~/…/%3~|%~)%f %(?.%F{99}.%F{red})%(!.#.❯)%f '
RPROMPT='${_git_info}'
