# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'err: %e'
zstyle :compinstall filename '/home/jof/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

export LANG=en_US.UTF8

alias dayfolder="mkdir $(date +%Y-%m-%d)"
alias s="sudo $*"
alias g="git $*"

alias nc='nc -v -v'
alias pstree='ps axjf'
alias psthreads='ps axms'
alias ll='ls -la'
alias vi='vim'

cd() {
 builtin cd "$@" && ll -ltrh
}

wiki(){
	dig +short txt $1.wp.dg.cx.
}

tincup(){
	s /etc/init.d/tinc start
}
tincdown(){
	s /etc/init.d/tinc stop
}

PATH=${HOME}/bin:/sbin:/usr/sbin:${PATH}:
export EDITOR=/usr/bin/vim

autoload -U promptinit
promptinit
prompt adam1 black

#initialize GPG agent
if test -f $HOME/.gpg-agent-info &&    kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
 GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
 export GPG_AGENT_INFO
else
 eval `gpg-agent --daemon`
 echo $GPG_AGENT_INFO >$HOME/.gpg-agent-info
fi

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
