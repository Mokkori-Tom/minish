# msys2 (https://github.com/msys2/msys2-installer/releases)
export APPDATA=$HOME/.config # windows appdata path
export download=C:/Users/$USERNAME/Downloads # windows DL path

export LANGUAGE=ja_JP.ja
export LANG=ja_JP.UTF-8

# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_DATA_HOME=$HOME/.local/share 
export XDG_CACHE_HOME=$HOME/.cache
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CONFIG_DIRS=/etc/xdg

export GOPATH=$OPT/go/go/
export EDITOR=nvim

# alias
alias ll='ls -la --color=auto'
alias gimp="gimp --no-splash"
alias krita="krita --nosplash"
alias curlk='curl -k --ssl-no-revoke -L -O'
alias wiki='nvim +VimwikiIndex'
alias scad='$OPT/scad/openscad-2021.01/openscad.exe'

# windowsのpythonダミーファイルに注意(削除する等)
alias python='$OPT/python/python'
alias pip='$OPT/python/Scripts/pip'

# Resource files
$OPT/pathread
source $OPT/.paths

# windows system path 
source $HOME/.pathrc

# HISTFILE
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL="ignoredups:erasedups"
export HISTIGNORE="ls:bg:fg:history:pwd"
shopt -s histappend 2>/dev/null
[ -f "$HISTFILE" ] && history -r

# PROMPT
 PROMPT_COMMAND='
   HOME_NAME=$(basename "$HOME")
   VENV=""
   if [ -n "$VIRTUAL_ENV" ]; then
     VENV="\[\e[35m\]("$(basename "$VIRTUAL_ENV")")\[\e[0m\]"
   fi
   history -a; history -n
   PS1="$VENV\[\e[32m\][$HOME_NAME]\[\e[36m\][$(date +%Y%m%d_%H:%M)]\[\e[0m\][\w]\n\$ "
 '

# FZF(https://github.com/junegunn/fzf)
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install --key-bindings --completion --no-update-rc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# 1. Command Conp bash> Ctrl+R → echo 'hello' 
# 2. File Conp bash> vim Ctrl+T → vim /etc/passw

realtime_rg_fzf() {
  local tmpfile=$(mktemp)
  rg --line-number --no-heading --color=never "" > "$tmpfile"
  while :; do
    local selected
    selected=$(fzf --ansi --delimiter : \
        --preview 'bat --style=numbers --color=always {1} --highlight-line {2}' \
        --preview-window='up:60%' \
        --prompt="Q rg > " \
        --header="Move:Up Dn, Select: Enter（Out: Esc）" \
        < "$tmpfile")
    [ -z "$selected" ] && break
    local file line
    file=$(echo "$selected" | cut -d: -f1)
    line=$(echo "$selected" | cut -d: -f2)
    [ -z "$file" ] && continue
    ${EDITOR:-nvim} +"$line" "$file"
  done
  rm -f "$tmpfile"
}
# Bash kye
if [[ $- == "*i*" ]]; then
  bind -x '"\C-g": realtime_rg_fzf'
fi
