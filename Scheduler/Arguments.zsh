#!/usr/bin/env zsh

declare -a valid_tasks

function argument_usage {

  # Output shown on invalid argument set
  /bin/echo "Usage: $0 [-c] [--task <task_name>]... [--help]"
  /bin/echo "Options:"
  /bin/echo "  -c, --clear-cache   Clear the cache"
  /bin/echo "  --task <task_name>  Specify a task"
  /bin/echo "  --help              Show this help message"
  exit 1

}

function validate_arguments {

  # Command-Line argument parser
  declare -a tasks
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -c | --clear-cache)
        delete_cache
        shift ;;
      -t | --task)
        if [[ -n "$2" && ! "$2" == -* ]]; then
          tasks+=("$2")
          shift 2
        else
          fatal "Missing argument for --task"
        fi ;;
      -h | --help)
        argument_usage
        shift ;;
      *)
        fatal "Invalid option $1"
        break ;;
    esac
  done

  # Parse --task elements
  if [ ${#tasks[@]} -gt 0 ]; then
    for task in ${tasks[@]}; do
      if [[ ! "$task" =~ "^[a-zA-Z0-9-]+$" ]]; then
        error "\"$task\" contains invalid characters"
      fi
      valid_tasks+=("$task")
    done
  fi

}

