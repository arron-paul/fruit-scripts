#!/usr/bin/env zsh

function error {

  # Show error and continue
  local message="$1"
  /bin/echo "Failure: $message" >&2

}

function fatal {

  # Show fatal error and terminate with non-zero exit code
  local message="$1"
  /bin/echo "Fatal: $message" >&2
  exit 1

}

function requires {

  # Test availability of binary
  local binary=$1
  if ! /usr/bin/command -v "$binary" &> /dev/null; then
    fatal "Requirement \"$binary\" is not available on the PATH."
  fi

}

function validate_homebrew {

  # Test availability of `brew`
  local brew_bin="$1"
  requires "$brew_bin"
  # Evaluate `brew` export statements
  eval $("$brew_bin" shellenv)

}

readonly HOMEBREW_BIN=/opt/homebrew/bin/brew
validate_homebrew $HOMEBREW_BIN
