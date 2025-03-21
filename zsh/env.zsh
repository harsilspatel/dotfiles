export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/workspace"

export EDITOR="nvim"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL='ignoreboth:erasedups'

export GOKU_EDN_CONFIG_FILE="$DOTFILES/config/karabiner/karabiner.edn"

export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export MCFLY_RESULTS=100

export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$HOME/bin:/usr/local/bin:/opt/homebrew/opt/postgresql@15/bin:$PATH

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a"

# export JAVA_HOME=$(/usr/libexec/java_home)

export GPG_TTY=$(tty)

export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="$PATH:/Users/harsilspatel/.foundry/bin"

export PNPM_HOME="/Users/harsilspatel/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
