#!/usr/bin/env zsh

# clean stale files
brew cleanup --quiet

# purge stale plugs
nvim --headless +PlugClean +q +q

# remove plugins not in list
"$DOTFILES/tpm/bin/clean_plugins"

# Remove swap and undo files if they haven't been modified in last 42 days since those
# do not contain the answer to the ultimate question of life, the universe and everything
for DIR_NAME in swap undo
do
  find "$HOME/.config/nvim/$DIR_NAME" -type f -mtime +42 -delete;
done

osascript -e 'display notification "brew, tpm and vim" with title "🧹 Removed stale files!"'
