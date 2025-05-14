# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

alias grep='grep --color=auto'
alias ll='ls -alh --color=auto'
alias ls='ls --color=auto'
alias sv='sudo nvim'
alias v='nvim'
