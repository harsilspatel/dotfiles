#!/usr/bin/env zsh

osascript -e 'display notification "zinit, homebrew, vim-plug" with title "🛠 Updating tools..."'

# sourcing zinit for non-interactive shell
source "$HOME/.zinit/bin/zinit.zsh"
# update zinit
zinit self-update
# update plugins
zinit update --all --parallel --quiet

# update tmux plugins
"$DOTFILES/tpm/bin/update_plugins" all

# update vim-plug, plugins (an extra +q to quit startify buffer)
nvim --headless +PlugUpgrade +PlugUpdate +q +q

# update brew
brew update
# update formulae
brew upgrade --greedy --quiet

osascript -e 'display notification "zinit, homebrew, tpm, vim-plug" with title "💪 Update complete!"'
