function toon {
  echo -n ""
}

get_git_dirty() {
  git diff --quiet || echo '*'
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' 🚧'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr ' 📦'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats \
    '%F{5}%F{2}→ %F{2}%b%F{3}|%F{1}%a%c%u%F{5}%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}%F{2}→ %F{2}%b%c%u%F{5}%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn

theme_precmd () {
    vcs_info
}

git_user() {
    git config --get user.email
}

vcs_wrapper () {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
	echo " %{$fg_bold[green]%}⌥%{$reset_color%}%{$fg[green]%} $(git_user)%{$reset_color%}"
    fi
}

setopt prompt_subst
PROMPT='
%{$fg[cyan]%}%(3~|../%1~|%~) $(toon)%  %n%{$reset_color%}$(vcs_wrapper)%{$reset_color%} %{$fg[yellow]%}\$%{$reset_color%} '

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
