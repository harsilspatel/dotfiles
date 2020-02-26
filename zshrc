zmodload zsh/zprof

source ~/.dotfiles/.tokens
source ~/.dotfiles/.exports
source ~/.dotfiles/.aliases
source ~/.dotfiles/.functions

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# syntax highlighting and auto-suggestions
zi wait'0' lucid for \
 atinit'zicompinit; zicdreplay' \
    zdharma/fast-syntax-highlighting \
 compile'{src/*.zsh,src/strategies/*}' \
 atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \

zinit ice wait'1' atload"unalias grv; alias gf=\"grunt f\"" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait'1' lucid
zinit light lukechilds/zsh-nvm

zinit ice wait'1' lucid
zinit light rupa/z

zinit ice wait'1' lucid
zinit light igoradamenko/npm.plugin.zsh

zinit ice wait'2' lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice depth=1;
zinit light romkatv/powerlevel10k


# to separate history for iterm tabs
unsetopt share_history
unsetopt inc_append_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
