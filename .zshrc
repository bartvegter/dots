HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt append_history inc_append_history share_history # better history
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # adds a slash instead of a trailing space on dir completion
setopt extendedglob # match ~ # ^
unsetopt beep

# Aliases
alias -- grep='grep --color=auto'
alias -- ll='ls -alh --color=auto'
alias -- ls='ls --color=auto'
alias -- sv='sudo nvim'
alias -- v='nvim'

zstyle :compinstall filename '/home/bart/.zshrc'

zmodload zsh/complist
autoload -Uz compinit promptinit

compinit
promptinit
prompt redhat

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

eval "$(starship init zsh)"
