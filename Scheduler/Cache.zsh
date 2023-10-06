#!/usr/bin/env zsh

readonly CACHE_FILE="$BASE_DIR/Cache"

function generate_cache_content {

  # Generate the contents of the cache
  readonly task_dir=$1
  local cache_content
  for task in $task_dir/**/*.zsh; do
    if [[ -f "$task" ]]; then

      # Check for task scheduling metadata
      if /usr/bin/grep -qE '^# (Name|Deps):' "$task"; then

        local name=$(awk '/^# Name:/ {print $NF}' "$task")
        local deps=$(awk '/^# Deps:/ {print $NF}' "$task")

        # Cache line entry for task
        if [[ -n "$name" && -n "$deps" ]]; then
          cache_content+="$name,$task,$deps\n"
        fi

      fi

    fi
  done
  echo $cache_content

}

function generate_cache {

  # Generate base64-encoded cache file with task entries
  readonly task_dir=$1
  /bin/echo "$(generate_cache_content $task_dir | base64)" > "$CACHE_FILE"
  /usr/bin/chflags hidden "$CACHE_FILE"

}

function validate_cache {

  # Future: Add invalidation logic
  readonly task_dir="$1"
  if [[ -e "$CACHE_FILE" ]]; then
    return
  fi
  generate_cache "$task_dir"

}

function delete_cache {

  # Remove and re-generate cache
  /bin/rm -r "$CACHE_FILE"
  validate_cache "$tasks_dir"

}

function get_cache {

  # Get decoded cache content
  /bin/cat "$CACHE_FILE" | /usr/bin/base64 -d

}
