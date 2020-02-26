zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/Cellar/openvpn/2.4.8/sbin:$PATH

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# A.
setopt promptsubst

# B.
zinit snippet OMZ::/lib/bzr.zsh
zinit snippet OMZ::/lib/clipboard.zsh
zinit snippet OMZ::/lib/compfix.zsh
zinit snippet OMZ::/lib/completion.zsh
zinit snippet OMZ::/lib/correction.zsh
zinit snippet OMZ::/lib/diagnostics.zsh
zinit snippet OMZ::/lib/directories.zsh
zinit snippet OMZ::/lib/functions.zsh
zinit snippet OMZ::/lib/git.zsh
zinit snippet OMZ::/lib/grep.zsh
zinit snippet OMZ::/lib/history.zsh
zinit snippet OMZ::/lib/key-bindings.zsh
zinit snippet OMZ::/lib/misc.zsh
zinit snippet OMZ::/lib/prompt_info_functions.zsh
zinit snippet OMZ::/lib/spectrum.zsh
zinit snippet OMZ::/lib/termsupport.zsh
zinit snippet OMZ::/lib/theme-and-appearance.zsh

# C.
zinit ice wait atload"unalias grv; alias gf=\"grunt f\"" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

# D.
PS1="READY >" # provide a nice prompt till the theme loads
zinit ice wait'!' lucid
zinit snippet OMZ::themes/robbyrussell.zsh-theme

# Syntax highlighting
# (compinit without `-i` spawns warning on `sudo -s`)
zinit ice wait"0a" lucid atinit"ZINIT[COMPINIT_OPTS]='-i' zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

# Autosuggestions
# Note: should go _after_ syntax highlighting plugiuun
zinit light zsh-users/zsh-autosuggestions
# zinit ice wait"0a" lucid atload"_zsh_autosuggest_start"; 
# zinit ice wait"0a" lucid ZSH_AUTOSUGGEST_USE_ASYNC=1
# export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

zinit ice wait'1' lucid
zinit light lukechilds/zsh-nvm

zinit ice wait'1' lucid
zinit light rupa/z

zinit ice wait'1' lucid
zinit light igoradamenko/npm.plugin.zsh

zinit ice wait'2' lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice depth=1; zinit light romkatv/powerlevel10k

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
