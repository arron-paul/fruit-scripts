#!/usr/bin/env zsh
# Name: Mount-Shares
# Deps: None

# This must be run as non-root for session interaction

function mount_smb_share {
  local hostname=$1
  local username=$2
  local password=$3
  local share=$4
  # If the mount is activated with `mount_smbfs` a Finder window will appear for each share that is mounted,
  # and thus would make for a bad time. A trick around this is to invoke the mounting procedure using AppleScript.
  /usr/bin/osascript -e "
    tell application \"Finder\"
      if not (disk \"$share\" exists) then
        try
          mount volume \"smb://$hostname/$share\" as user name \"$username\" with password \"$password\"
        end try
      end if
    end tell
  " > /dev/null 2>&1
}

function mount_smb_shares {
  local hostname="$1"
  local username="$2"
  local password="$3"
  shift 3
  for share in $@; do
    if [ -d /Volumes/$share ]; then continue; fi
    mount_smb_share $hostname $username $password $share
  done
}

function unmount_share {
  local share=$1
  /usr/bin/osascript -e "tell application \"Finder\" to eject disk \"$share\"" > /dev/null 2>&1
}

function unmount_shares {
  for share in $@; do
    unmount_share $share
  done
}
