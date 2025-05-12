

# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias grep='grep --color=auto'
alias h='cd /home/bart/.hyprnix'
alias hl='lazygit --path=/home/bart/.hyprnix'
alias hv='cd /home/bart/.hyprnix && $EDITOR'
alias iv='nsxiv -ftars f'
alias iv-random='find . -type f | shuf | nsxiv -ifars f'
alias ll='ls -alh --color=auto'
alias ls='ls --color=auto'
alias sr=/nix/store/s8fhwc40a21xnlzv80ibp3rrs16ish83-systemRebuild/bin/systemRebuild
alias sv='sudo nvim'
alias v=nvim

if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
  . "/nix/store/p6w9gjn29bnl5w566jwgrk6zj9kkn96z-bash-completion-2.14.0/etc/profile.d/bash_completion.sh"
fi

. /nix/store/dx713qrwiiplmiw2hjyigw3029sawp7l-autojump-22.5.3/share/autojump/autojump.bash

if [[ $TERM != "dumb" ]]; then
  eval "$(/etc/profiles/per-user/bart/bin/starship init bash --print-full-init)"
fi

