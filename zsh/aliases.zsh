# oh my zsh
alias /="cd /"
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# settings
alias c="code ."
alias i="idea ."
alias ch="wc -l $HISTFILE; cp $HISTFILE $HISTFILE.bak; nl ~/.zsh_history | LC_ALL=C sort -k 2  -k 1,1nr| uniq -f 1 | LC_ALL=C sort -n | cut -f 2 > $HISTFILE; wc -l $HISTFILE;"
alias e="exa -alrs=created"
alias h="cat $HISTFILE | grep "
alias j="jest"
alias l="lazygit"
alias o="open ."
alias rmrfnm="rm -rf ./node_modules"
alias v="$EDITOR"
alias vim="$EDITOR"
alias x="exit"
alias nm="nodemon"

# github
alias ghpv="gh pr view -w"
alias ghrv="gh repo view -w"

# yarn
alias y="yarn"
alias ya="yarn add"
alias yad="yarn add -D"
alias yd="yarn dev || yarn develop"
alias yga="yarn global add"
alias ygr="yarn global remove"
alias yr="yarn remove"
alias ys="yarn start"
alias yt="yarn test"
alias yy="yarn dev || yarn develop || yarn start"

# npm
alias na="npm audit"
alias naf="npm audit fix"
alias nd="npm run dev || npm run develop"
alias ni="npm i"
alias nid="npm i -D"
alias nig="npm i -g"
alias np="npm prune"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"
alias nu="npm uninstall"
alias nv="npm version"

# tmux
alias t="tmux"
alias ta="tmux attach -t"
alias tk="tmux kill-session -t"
alias tks="tmux kill-server"
alias tl="tmux list-sessions"
alias tn="tmux new-session -s"

# frequent files
alias va="$EDITOR \"$DOTFILES/zsh/.aliases\""
alias vd="code $DOTFILES"
alias vc="crontab -e"
alias ve="$EDITOR \"$DOTFILES/zsh/.zshenv\""
alias vf="$EDITOR \"$DOTFILES/zsh/.functions\""
alias vl="$EDITOR \"$DOTFILES/lazygit/config.yml\""
alias vm="$EDITOR \"$DOTFILES/config/nvim/maps.vim\""
alias vp="$EDITOR \"$DOTFILES/zsh/.p10k.zsh\""
alias vpj="$EDITOR package.json"
alias vs="$EDITOR \"$DOTFILES/config/skhd/skhdrc\""
alias vt="$EDITOR \"$DOTFILES/.tmux.conf\""
alias vv="$EDITOR \"$DOTFILES/config/nvim/init.vim\""
alias vy="$EDITOR \"$DOTFILES/config/yabai/yabairc\""
alias vz="$EDITOR \"$DOTFILES/zsh/.zshrc\""

# git
alias ga="git add"
alias gb="git browse"
alias gaa="git add --all"
alias gau="git add --update"
alias gc="git commit -v -m"
alias gca="git commit -v --amend -m"
alias gcane="git commit -v --amend --no-edit"
alias gcd="git checkout develop"
alias gcl="git clone"
alias gcm="git checkout master"
alias gcnv="git commit -v --no-verify -m"
alias gco="git checkout"
alias gcop="git checkout @{-1}" # checkout the previously checkedout branch
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gd="git diff"
alias gdc="git diff --color-words=."
alias gdni="git diff --no-index"
alias gdw="git diff --color-words"
alias ggc="git gc --aggresive"
alias gl="git pull"
alias glog="git log --oneline --decorate --graph"
alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gp="git push"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias grv="git remote -v"
alias gski="git stash push --keep-index"
alias gsl="git stash list"
alias gspo="git stash apply"
alias gspu="git stash push -u"
alias gst="git status"

# taken from https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# blueutil
alias b="blueutil"
alias bd="blueutil --disconnect \"WH-1000XM3\""
alias bh="blueutil --connect \"WH-1000XM3\""
alias bo="blueutil --power 1"
alias bt="blueutil --power toggle"
alias bz="blueutil --power 0"

alias tf="terraform"

alias s="serverless"

alias d="docker"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
