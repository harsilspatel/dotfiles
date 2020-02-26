zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000
export PATH=$HOME/bin:/usr/local/bin:/usr/local/Cellar/openvpn/2.4.8/sbin:$PATH

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

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi


# syntax highlighting and auto-suggestions
zi wait'0' lucid for \
 atinit'zicompinit; zicdreplay' \
    zdharma/fast-syntax-highlighting \
 compile'{src/*.zsh,src/strategies/*}' \
 atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \

zinit ice wait'0' atload"unalias grv; alias gf=\"grunt f\"" lucid
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

# for setting the foreground color, read more at https://stackoverflow.com/a/52713893/9701238
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

export JAVA_HOME=$(/usr/libexec/java_home)
export HISTCONTROL='ignoreboth';

function lcode() {
  set -x
  f=$1
  git add $f
  git commit -v -m "add ${f}"
  git push
  set +x
}

function lc() {
  if [[ "$PWD" == "/Users/harsilpatel/Workspace/leetcode" ]]
    then
    f=$(ls -t | head -n 1)
    lcode $f 
  fi
}

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

source ~/.dotfiles/.tokens
source ~/.dotfiles/.aliases

function api() {
    git clone https://gitlab.com/medipass/software/medipass-api.git
    cd medipass-api
    npm i
    mkdir ./.vscode
    cp ~/Workspace/commons/launch.json ./.vscode/launch.json
    cp ~/Workspace/commons/Gruntfile.js ./Gruntfile.js
}

# to separate history for iterm tabs
unsetopt share_history
unsetopt inc_append_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
