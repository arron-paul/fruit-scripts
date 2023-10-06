<img src="../support/Support/Images/Wordmark.png?raw=true" width="200" alt="Logo" />

A collection of subtle life improvements for OS X.

#### What’s this?

This repository houses a selection of scripts that I've personally assembled for my OS X setup. Some scripts are used on-demand, while others are scheduled as recurring tasks, primarily for system maintenance, automation, and aesthetic improvements.
These scripts are written in `zsh` and have been fine-tuned over the years.

#### How to utilise these scripts?

There are two flavours of scripts:
- One-Shot Scripts: These are typically used after a fresh OS X installation to configure your system.
- Recurring Scheduled Tasks: These scripts automate various maintenance tasks, running on a daily, weekly or monthly basis.

#### Scheduled Tasks

Each scheduled task resides in a separate `.zsh` script file located in the `./Scheduled` directory.

A task consists of two important properties:
- Name: This uniquely identifies the task and its corresponding script.
- Dependencies: These specify the necessary binaries that must be available in your `$PATH` before the task can execute. If any dependencies are missing, the task will not run.

Here's an example of a task and its associated `.zsh` script:

```zsh
#!/usr/bin/env zsh
# Name: Convert-Video
# Deps: ffmpeg

# Logic
```

#### The Scheduler


Scheduled tasks are executed by the Scheduler, which acts as an abstraction layer and seamlessly integrates with `crontab`.

<img src="../support/Support/Images/Crontab Example.png?raw=true"  alt="Logo" />

##### Command-Line Options for Scheduler.zsh

- `--task` Specify a task to be run identified by the task name. `--task` arguments can be chained.
- `--clear-cache` Invalidates the cache.

#### Diagnostics

Fruit Scripts include a `log_to_console` function that can be used to write messages to the console. This feature is handy for diagnostic purposes or to log important information.
