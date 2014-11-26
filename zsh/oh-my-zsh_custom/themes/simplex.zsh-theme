ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "  $(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX "
  fi
}

username() {
    if [[ ${SKIPED_USERNAMES[(r)$USER]} == "" ]];then
        echo $USER"@"
    fi
}

if [ -z "$HOST_COLOR" ];then
    HOST_COLOR="green"
fi

# %B - bold on
# %b - bold off
# %~ - current dir
# %m - current host
PROMPT='
%B%{$fg[$HOST_COLOR]%}$(username)%m%{$reset_color%}%b:%B%{$fg[blue]%}%~%{$reset_color%}%b$(git_custom_status)
$ '
