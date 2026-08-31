# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

alias c='vscodium'
alias grep='grep --color=auto'
alias ll='eza -alh --smart-group'
alias ls='eza -a'
alias tree='eza --tree'
alias sv='sudo nvim'
alias v='nvim'
alias paru='paru --color always'
