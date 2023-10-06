#!/usr/bin/env zsh
# Name: Flush-IconCache
# Deps: None

# Clearing icon caches requires `sudo` access

/usr/bin/sudo /usr/bin/find /private/var/folders/ -name com.apple.dock.iconcache -exec /bin/rm {} \;
/usr/bin/sudo /usr/bin/find /private/var/folders/ -name com.apple.iconservices -exec /bin/rm -rf {} \;
/usr/bin/sudo /bin/rm -rf /Library/Caches/com.apple.iconservices.store

for app in "Dock" "Finder"; do
  /usr/bin/killall "${app}" &> /dev/null;
done

log_to_console "Flushed icon cache"

exit 0
