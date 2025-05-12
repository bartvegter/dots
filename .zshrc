

typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/0xy5m4xbkx8bjkb5a216q2n6v2lh3gh5-zsh-5.9/share/zsh/$ZSH_VERSION/help"





# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit
source /nix/store/gdapnjy6s6prvapk33a9mf709a00rphw-zsh-autosuggestions-0.7.0/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)







# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY
setopt autocd

if [[ $TERM != "dumb" ]]; then
  eval "$(/etc/profiles/per-user/bart/bin/starship init zsh)"
fi

. /nix/store/dx713qrwiiplmiw2hjyigw3029sawp7l-autojump-22.5.3/share/autojump/autojump.zsh


# Aliases
alias -- grep='grep --color=auto'
alias -- h='cd /home/bart/.hyprnix'
alias -- hl='lazygit --path=/home/bart/.hyprnix'
alias -- hv='cd /home/bart/.hyprnix && $EDITOR'
alias -- iv='nsxiv -ftars f'
alias -- iv-random='find . -type f | shuf | nsxiv -ifars f'
alias -- ll='ls -alh --color=auto'
alias -- ls='ls --color=auto'
alias -- sr=/nix/store/s8fhwc40a21xnlzv80ibp3rrs16ish83-systemRebuild/bin/systemRebuild
alias -- sv='sudo nvim'
alias -- v=nvim

# Named Directory Hashes


source /nix/store/ghfps9cfy7wlxgly5iz3vw3a2kclbjz5-zsh-syntax-highlighting-0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS+=()




