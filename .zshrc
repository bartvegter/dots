# ══════════════════════════════════════════════
# History
# ══════════════════════════════════════════════
HISTFILE=~/.histfile         # file where history is persisted
HISTSIZE=10000               # entries kept in memory per session
SAVEHIST=10000               # entries kept in the history file

setopt append_history        # append instead of overwrite HISTFILE
setopt inc_append_history    # write each command to file immediately
setopt share_history         # share history across open terminals
setopt hist_ignore_all_dups  # drop older duplicates, keep newest
setopt hist_ignore_space     # commands starting with a space aren't recorded
setopt hist_reduce_blanks    # strip redundant whitespace before saving

# ══════════════════════════════════════════════
# Options
# ══════════════════════════════════════════════
setopt auto_menu             # Tab automatically enters completion menu
setopt menu_complete         # Tab inserts first match, cycles on repeat
setopt autocd                # typing a dir path cds into it
setopt auto_param_slash      # dir completion adds '/' not a space
setopt extendedglob          # enable ^ ~ # glob operators
unsetopt beep                # disabled beep on errors

# ══════════════════════════════════════════════
# Aliases
# ══════════════════════════════════════════════
alias -- c='vscodium'
alias -- grep='grep --color=auto'
alias -- ls='eza -a'
alias -- ll='eza -alh --smart-group'
alias -- tree='eza --tree'
alias -- v='nvim'
alias -- sv='sudo nvim'
alias -- paru='paru --color always'

# ══════════════════════════════════════════════
# Completion
# ══════════════════════════════════════════════
zstyle :compinstall filename "$HOME/.zshrc"     # record owner of compinstall config
zmodload zsh/complist                           # menu list widget (used by menu_complete)
autoload -Uz compinit

# Cache completions: reuse dump unless older than 24h
# (avoids scanning fpath on every shell start — biggest single startup win)
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh-24) ]]; then
  compinit -C                                  # reuse cached dump, skip security scan
else
  compinit                                     # rebuild dump (incl. security check)
fi

# Case-insensitive substring matching + interactive menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

# ══════════════════════════════════════════════
# Environment
# ══════════════════════════════════════════════
export PATH="$PATH:$HOME/.local/bin"

# ══════════════════════════════════════════════
# fnm — Node.js version management (replaces nvm)
# ══════════════════════════════════════════════
# `--use-on-cd` reads .nvmrc / .node-version automatically when
# you cd into a directory and switches Node versions accordingly
eval "$(fnm env --use-on-cd --shell zsh)"

# ══════════════════════════════════════════════
# Tools initialized via eval
# ══════════════════════════════════════════════
eval "$(batman --export-env)"   # use bat as MANPAGER
eval "$(starship init zsh)"     # prompt
eval "$(zoxide init zsh)"       # z smart directory jumping

# ══════════════════════════════════════════════
# Plugins — syntax highlighting must be sourced LAST
# ══════════════════════════════════════════════
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh