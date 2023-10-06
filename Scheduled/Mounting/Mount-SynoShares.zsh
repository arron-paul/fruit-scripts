#!/usr/bin/env zsh
# Name: Mount-SynoShares
# Deps: None

source "$(dirname "$0")/Mount-Shares.zsh"

# Mount shares if Synology is available
if /sbin/ping -c 1 $syno_host > /dev/null 2>&1; then
  mount_smb_shares $syno_host $syno_user $syno_pass $syno_shares
else
  unmount_shares $syno_shares
fi

function syno_post_mount {

  # Hide recycle bin
  for share in ${syno_shares[@]}; do
    if [ ! -d /Volumes/$share ]; then continue; fi
    chflags hidden "/Volumes/$share/#recycle" > /dev/null 2>&1
  done

}

syno_post_mount

exit 0
