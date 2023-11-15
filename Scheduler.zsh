#!/usr/bin/env zsh

readonly BASE_DIR=$(realpath "$(dirname "$0")")
readonly TASKS_DIR="$BASE_DIR/Scheduled"

source "$BASE_DIR/Scheduler/Core.zsh"
source "$BASE_DIR/Scheduler/Functions.zsh"
source "$BASE_DIR/Scheduler/Cache.zsh"
source "$BASE_DIR/Scheduler/Arguments.zsh"

echo hi

validate_cache "$TASKS_DIR"
validate_arguments $@

declare OLD_IFS=$IFS
while IFS= read -r line; do IFS=',' read -r task_name task_path task_reqs <<< "$line"

  # Validate task name
  [[ $task_name =~ ^[A-Za-z0-9-]+$ ]] || fatal "Task name is not valid: $task_name"

  # Ensure task exists
  [[ -e "$task_path" ]] || fatal "Task cannot be found: $task_path"

  # Validate task dependencies
  if [[ "$task_reqs" != *None* ]]; then
    for task_req in ${(s:+:)task_reqs}; do
      requires $task_req
    done
  fi

  # Iterate through each valid task argument and
  # match the task with the task entry in the cache
  for valid_task in ${valid_tasks[@]}; do

    if [[ $valid_task != $task_name ]]; then
      continue
    fi

    # Environment Variables
    if [[ -e "$(dirname "$task_path")"/.env ]]; then
      source "$(dirname "$task_path")"/.env
    fi

    # Run Task
    source "$task_path"

  done

done <<< $(get_cache)
IFS=$OLD_IFS

exit 0
