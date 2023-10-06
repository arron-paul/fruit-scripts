#!/usr/bin/env zsh
# Name: Remove-UnwantedItems
# Deps: None

setopt +o nomatch

# Removing some of these files could have unintended consequences
declare unwanted_items=(

  # `less` configuration and history information
  $HOME/.lesshst

)

for unwanted_item in ${unwanted_items[@]}; do
  /bin/rm -rf $unwanted_item
done

log_to_console "Deleted unwanted items"

exit 0
