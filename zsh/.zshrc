# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/opt/zinit/zinit.zsh

function compile_and_source() {
  file="$1"
  if [[ -e "$file" ]] \
     && [[ ! -e "$file.zwc" ]] \
     || [[ "$file" -nt "$file.zwc" ]]; then
       zcompile "$file"
  fi
  source "$file"
}

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

bindkey -e # Use emacs key bindings

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

# # syntax highlighting and auto-suggestions
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# load module for list-style selection
zmodload zsh/complist
# use the module above for autocomplete selection
zstyle ':completion:*' menu yes select

zinit light romkatv/zsh-defer
zinit snippet OMZ::/lib/completion.zsh

zinit ice depth=1;
zinit light romkatv/powerlevel10k

zinit ice lucid
zinit light rupa/z

zinit ice lucid wait"1" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"'
zinit light cantino/mcfly

zinit ice wait'2' lucid
zinit light hlissner/zsh-autopair

zinit ice wait'3' lucid
zinit snippet OMZ::plugins/pyenv/pyenv.plugin.zsh

setopt hist_ignore_all_dups

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(fnm env --use-on-cd --shell zsh)"

zsh-defer -c "eval \"$(pyenv init --path)\""
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/terraform terraform

for file in env.zsh \
            fzf.zsh \
            tokens.zsh \
            aliases.zsh \
            functions.zsh \
            p10k.zsh; do
  compile_and_source "$DOTFILES/zsh/$file"
done
unset file


# pnpm
export PNPM_HOME="/Users/harsilspatel/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
