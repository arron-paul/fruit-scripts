#!/usr/bin/env zsh
# Name: Unmount-DuplicateShares
# Deps: None

# Find shares that have been mounted multiple times and attempt
# to unmount the duplicates, leaving the original share mounted
for duplicate_share in $(find /Volumes -maxdepth 1 -name '*-[0-9]*'); do
  if /sbin/umount $duplicate_share > /dev/null; then
    log_to_console "Unmounted duplicated share \"$duplicate_share\""
  fi
done

exit 0
