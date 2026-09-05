# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=10000
HISTSIZE=10000

# ══════════════════════════════════════════════
# Aliases
# ══════════════════════════════════════════════
alias c='vscodium'
alias grep='grep --color=auto'
alias ll='eza -alh --smart-group'
alias ls='eza -a'
alias tree='eza --tree'
alias v='nvim'
alias sv='sudo nvim'
alias paru='paru --color always'

# ══════════════════════════════════════════════
# Environment
# ══════════════════════════════════════════════
export PATH="$PATH:$HOME/.local/bin"

# ══════════════════════════════════════════════
# fnm — Node.js version management (replaces nvm)
# ══════════════════════════════════════════════
# `--use-on-cd` reads .nvmrc / .node-version automatically when
# you cd into a directory and switches Node versions accordingly
eval "$(fnm env --use-on-cd --shell bash)"

# ══════════════════════════════════════════════
# Tools initialized via eval
# ══════════════════════════════════════════════
eval "$(batman --export-env)"   # use bat as MANPAGER
eval "$(starship init bash)"    # prompt
eval "$(zoxide init bash)"      # z smart directory jumping