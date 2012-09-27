## Shell options
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'err: %e'
zstyle :compinstall filename '/home/jof/.zshrc'

autoload -Uz compinit
compinit

for zshrc_snipplet in ~/.zsh.d/S[0-9][0-9]*[^~]; do
  source $zshrc_snipplet
done

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
# Don't save repeats in history.
setopt hist_ignore_all_dups
# Ignore saving commands preceded by a space
setopt hist_ignore_space

## Personal options
export LANG=en_US.UTF8
setopt appendhistory autocd extendedglob
unsetopt beep nomatch
export EDITOR=vim
bindkey -v
bindkey -M vicmd '?' history-incremental-search-backward
function vi-repeat-incremental-search-backward {
  bindkey -e
  zle -U $'\C-r'
  zle history-incremental-search-backward
  bindkey -v
}
zle -N vi-repeat-incremental-search-backward
bindkey -a N vi-repeat-incremental-search-backward

alias dayfolder="mkdir $(date +%Y-%m-%d)"
alias s="sudo $*"
alias g="git $*"
alias nc='nc -v -v'
alias pstree='ps axjf'
alias psthreads='ps axms'
alias ll='ls -la'
alias vi='vim'
alias grep="grep --color=auto"

cd() { builtin cd "$@" && ll -ltrh }

wiki(){
	dig +short txt $1.wp.dg.cx.
}

tincup(){
	s /etc/init.d/tinc start
}
tincdown(){
	s /etc/init.d/tinc stop
}

findgrep() {
  if [ -n "$1" ] && [ -n "$2" ]; then
    find $1 '!' -iwholename '*/.svn/*' '!' -iwholename '*/.git/*'  -exec grep -Hi "$2" {} \;
  else
    echo "Usage: findgrep {path} {pattern}"
  fi
}

digtrace() {
  if [ -n "$1" ] && [ -n "$2" ]; then
    dig +trace @a.root-servers.net "$1" IN "$2"
  elif [ -n "$1" ]; then
    dig +trace @a.root-servers.net "$1" IN A
  fi
}

original_offlineimap=`which offlineimap >/dev/null 2>&1`
offlineimap() {
  mount_crypt mail && $original_offlineimap
}


PATH=${HOME}/bin:/sbin:/usr/sbin:${PATH}:

autoload -U promptinit
type promptinit 2>&1 >/dev/null
if [ $? -eq 0 ]; then
  promptinit 2>/dev/null
  if [ $? -eq 0 ]; then
    prompt adam1 black
  fi
fi

# Initialize GPG agent, if installed.
which gpg-agent >/dev/null 2>&1 && {
  if test -f $HOME/.gpg-agent-info &&    kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
    GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
    export GPG_AGENT_INFO
  else
    eval `gpg-agent --daemon`
    echo $GPG_AGENT_INFO >$HOME/.gpg-agent-info
  fi
}

# Configure Awesome
export XDG_CONFIG_HOME=~/.config

# Fix misbehaving java in XCB
export AWT_TOOLKIT=MToolkit

# Auto-screen invocation.
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session. Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
#if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ]
#then
# STARTED_SCREEN=1 ; export STARTED_SCREEN
# [ -d $HOME/lib/screen-logs ] || mkdir -p $HOME/lib/screen-logs
# sleep 1
# screen -U -D -R && exit 0
## TERM=screen screen -D -R && exit 0
# # normally, execution of this rc script ends here...
# echo "Screen failed! continuing with normal bash startup"
#fi
