#!/bin/bash
config_file="$HOME/.claude/statusline-config.txt"
if [ -f "$config_file" ]; then
  source "$config_file"
  show_dir=$SHOW_DIRECTORY
  show_branch=$SHOW_BRANCH
  show_usage=$SHOW_USAGE
  show_bar=$SHOW_PROGRESS_BAR
  show_reset=$SHOW_RESET_TIME
  show_context=$SHOW_CONTEXT
  show_git_status=${SHOW_GIT_STATUS:-1}
else
  show_dir=1
  show_branch=1
  show_usage=1
  show_bar=1
  show_reset=1
  show_context=1
  show_git_status=1
fi

input=$(cat)
current_dir_path=$(echo "$input" | grep -o '"current_dir":"[^"]*"' | sed 's/"current_dir":"//;s/"$//')
current_dir=$(basename "$current_dir_path")
BLUE=$'\033[0;34m'
GREEN=$'\033[0;32m'
GRAY=$'\033[0;90m'
YELLOW=$'\033[0;33m'
RESET=$'\033[0m'

# 10-level gradient: dark green → deep red
LEVEL_1=$'\033[38;5;22m'   # dark green
LEVEL_2=$'\033[38;5;28m'   # soft green
LEVEL_3=$'\033[38;5;34m'   # medium green
LEVEL_4=$'\033[38;5;100m'  # green-yellowish dark
LEVEL_5=$'\033[38;5;142m'  # olive/yellow-green dark
LEVEL_6=$'\033[38;5;178m'  # muted yellow
LEVEL_7=$'\033[38;5;172m'  # muted yellow-orange
LEVEL_8=$'\033[38;5;166m'  # darker orange
LEVEL_9=$'\033[38;5;160m'  # dark red
LEVEL_10=$'\033[38;5;124m' # deep red

# Build components (without separators)
dir_text=""
if [ "$show_dir" = "1" ]; then
  dir_text="${BLUE}${current_dir}${RESET}"
fi

RED=$'\033[0;31m'

branch_text=""
if [ "$show_branch" = "1" ]; then
  git_dir=$(git rev-parse --git-dir 2>/dev/null)
  if [ -n "$git_dir" ]; then
    branch=$(git branch --show-current 2>/dev/null)
    # During detached HEAD (e.g. rebase), show short SHA
    [ -z "$branch" ] && branch=$(git rev-parse --short HEAD 2>/dev/null)

    if [ -n "$branch" ]; then
      # 2a. Detect merge/rebase state
      git_state=""
      if [ -d "$git_dir/rebase-merge" ]; then
        step=$(cat "$git_dir/rebase-merge/msgnum" 2>/dev/null)
        total=$(cat "$git_dir/rebase-merge/end" 2>/dev/null)
        git_state=" (REBASING ${step}/${total})"
      elif [ -d "$git_dir/rebase-apply" ]; then
        step=$(cat "$git_dir/rebase-apply/next" 2>/dev/null)
        total=$(cat "$git_dir/rebase-apply/last" 2>/dev/null)
        git_state=" (REBASING ${step}/${total})"
      elif [ -f "$git_dir/MERGE_HEAD" ]; then
        git_state=" (MERGING)"
      fi

      # 2b. Ahead/behind (only when NOT in merge/rebase)
      git_ahead=""
      git_behind=""
      if [ -z "$git_state" ]; then
        lr=$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
        if [ -n "$lr" ]; then
          behind=$(echo "$lr" | cut -f1)
          ahead=$(echo "$lr" | cut -f2)
          [ "$ahead" -gt 0 ] 2>/dev/null && git_ahead=" ↑${ahead}"
          [ "$behind" -gt 0 ] 2>/dev/null && git_behind=" ↓${behind}"
        fi
      fi

      # 2c. Working tree status
      git_dirty_colored=""
      if [ "$show_git_status" = "1" ]; then
        staged=0; modified=0; untracked=0
        while IFS= read -r line; do
          xy="${line:0:2}"
          case "$xy" in
            "??"*) untracked=$((untracked + 1)) ;;
            *)
              [ "${xy:0:1}" != " " ] && [ "${xy:0:1}" != "?" ] && staged=$((staged + 1))
              [ "${xy:1:1}" != " " ] && [ "${xy:1:1}" != "?" ] && modified=$((modified + 1))
              ;;
          esac
        done < <(git status --porcelain 2>/dev/null)

        [ "$staged" -gt 0 ] && git_dirty_colored="${git_dirty_colored} ${GREEN}+${staged}${RESET}"
        [ "$modified" -gt 0 ] && git_dirty_colored="${git_dirty_colored} ${YELLOW}~${modified}${RESET}"
        [ "$untracked" -gt 0 ] && git_dirty_colored="${git_dirty_colored} ${RED}!${untracked}${RESET}"
      fi

      # 2d. Assemble branch_text
      branch_text="${GREEN}⎇ ${branch}${RESET}"
      [ -n "$git_state" ] && branch_text="${branch_text}${YELLOW}${git_state}${RESET}"
      [ -n "$git_ahead" ] && branch_text="${branch_text}${GREEN}${git_ahead}${RESET}"
      [ -n "$git_behind" ] && branch_text="${branch_text}${YELLOW}${git_behind}${RESET}"
      [ -n "$git_dirty_colored" ] && branch_text="${branch_text}${git_dirty_colored}"
    fi
  fi
fi

usage_text=""
if [ "$show_usage" = "1" ]; then
  swift_result=$(swift "$HOME/.claude/fetch-claude-usage.swift" 2>/dev/null)

  if [ $? -eq 0 ] && [ -n "$swift_result" ]; then
    utilization=$(echo "$swift_result" | cut -d'|' -f1)
    resets_at=$(echo "$swift_result" | cut -d'|' -f2)

    if [ -n "$utilization" ] && [ "$utilization" != "ERROR" ]; then
      if [ "$utilization" -le 10 ]; then
        usage_color="$LEVEL_1"
      elif [ "$utilization" -le 20 ]; then
        usage_color="$LEVEL_2"
      elif [ "$utilization" -le 30 ]; then
        usage_color="$LEVEL_3"
      elif [ "$utilization" -le 40 ]; then
        usage_color="$LEVEL_4"
      elif [ "$utilization" -le 50 ]; then
        usage_color="$LEVEL_5"
      elif [ "$utilization" -le 60 ]; then
        usage_color="$LEVEL_6"
      elif [ "$utilization" -le 70 ]; then
        usage_color="$LEVEL_7"
      elif [ "$utilization" -le 80 ]; then
        usage_color="$LEVEL_8"
      elif [ "$utilization" -le 90 ]; then
        usage_color="$LEVEL_9"
      else
        usage_color="$LEVEL_10"
      fi

      if [ "$show_bar" = "1" ]; then
        if [ "$utilization" -eq 0 ]; then
          filled_blocks=0
        elif [ "$utilization" -eq 100 ]; then
          filled_blocks=10
        else
          filled_blocks=$(( (utilization * 10 + 50) / 100 ))
        fi
        [ "$filled_blocks" -lt 0 ] && filled_blocks=0
        [ "$filled_blocks" -gt 10 ] && filled_blocks=10
        empty_blocks=$((10 - filled_blocks))

        # Build progress bar safely without seq
        progress_bar=" "
        i=0
        while [ $i -lt $filled_blocks ]; do
          progress_bar="${progress_bar}▓"
          i=$((i + 1))
        done
        i=0
        while [ $i -lt $empty_blocks ]; do
          progress_bar="${progress_bar}░"
          i=$((i + 1))
        done
      else
        progress_bar=""
      fi

      reset_time_display=""
      if [ "$show_reset" = "1" ] && [ -n "$resets_at" ] && [ "$resets_at" != "null" ]; then
        iso_time=$(echo "$resets_at" | sed 's/\.[0-9]*Z$//')
        epoch=$(date -ju -f "%Y-%m-%dT%H:%M:%S" "$iso_time" "+%s" 2>/dev/null)

        if [ -n "$epoch" ]; then
          # Detect system time format (12h vs 24h) from macOS locale preferences
          time_format=$(defaults read -g AppleICUForce24HourTime 2>/dev/null)
          if [ "$time_format" = "1" ]; then
            # 24-hour format
            reset_time=$(date -r "$epoch" "+%H:%M" 2>/dev/null)
          else
            # 12-hour format (default)
            reset_time=$(date -r "$epoch" "+%I:%M %p" 2>/dev/null)
          fi
          [ -n "$reset_time" ] && reset_time_display=$(printf " → Reset: %s" "$reset_time")
        fi
      fi

      usage_text="${usage_color}Usage: ${utilization}%${progress_bar}${reset_time_display}${RESET}"
    else
      usage_text="${YELLOW}Usage: ~${RESET}"
    fi
  else
    usage_text="${YELLOW}Usage: ~${RESET}"
  fi
fi

format_tokens() {
  local n=$1
  if [ "$n" -ge 1000000 ]; then
    local whole=$((n / 1000000))
    local frac=$(( (n % 1000000) / 100000 ))
    printf "%d.%dm" "$whole" "$frac"
  elif [ "$n" -ge 1000 ]; then
    printf "%dk" $((n / 1000))
  else
    printf "%d" "$n"
  fi
}

context_text=""
if [ "$show_context" = "1" ]; then
  context_pct=$(echo "$input" | grep -o '"used_percentage":[0-9]*' | head -1 | sed 's/"used_percentage"://')
  context_total=$(echo "$input" | grep -o '"context_window_size":[0-9]*' | head -1 | sed 's/"context_window_size"://')

  if [ -n "$context_pct" ] && [ "$context_pct" -ge 0 ] 2>/dev/null; then
    if [ "$context_pct" -le 10 ]; then
      ctx_color="$LEVEL_1"
    elif [ "$context_pct" -le 20 ]; then
      ctx_color="$LEVEL_2"
    elif [ "$context_pct" -le 30 ]; then
      ctx_color="$LEVEL_3"
    elif [ "$context_pct" -le 40 ]; then
      ctx_color="$LEVEL_4"
    elif [ "$context_pct" -le 50 ]; then
      ctx_color="$LEVEL_5"
    elif [ "$context_pct" -le 60 ]; then
      ctx_color="$LEVEL_6"
    elif [ "$context_pct" -le 70 ]; then
      ctx_color="$LEVEL_7"
    elif [ "$context_pct" -le 80 ]; then
      ctx_color="$LEVEL_8"
    elif [ "$context_pct" -le 90 ]; then
      ctx_color="$LEVEL_9"
    else
      ctx_color="$LEVEL_10"
    fi

    if [ "$context_pct" -eq 0 ]; then
      ctx_filled=0
    elif [ "$context_pct" -eq 100 ]; then
      ctx_filled=10
    else
      ctx_filled=$(( (context_pct * 10 + 50) / 100 ))
    fi
    [ "$ctx_filled" -lt 0 ] && ctx_filled=0
    [ "$ctx_filled" -gt 10 ] && ctx_filled=10
    ctx_empty=$((10 - ctx_filled))

    ctx_bar=" "
    i=0
    while [ $i -lt $ctx_filled ]; do
      ctx_bar="${ctx_bar}▓"
      i=$((i + 1))
    done
    i=0
    while [ $i -lt $ctx_empty ]; do
      ctx_bar="${ctx_bar}░"
      i=$((i + 1))
    done

    ctx_sizes=""
    if [ -n "$context_total" ] && [ "$context_total" -gt 0 ] 2>/dev/null; then
      context_used=$(( context_total * context_pct / 100 ))
      ctx_sizes=" ($(format_tokens $context_used)/$(format_tokens $context_total))"
    fi

    context_text="${ctx_color}Context: ${context_pct}%${ctx_bar}${ctx_sizes}${RESET}"
  else
    context_text="${YELLOW}Context: ~${RESET}"
  fi
fi

output=""
separator="${GRAY} │ ${RESET}"

[ -n "$dir_text" ] && output="${dir_text}"

if [ -n "$branch_text" ]; then
  [ -n "$output" ] && output="${output}${separator}"
  output="${output}${branch_text}"
fi

if [ -n "$context_text" ]; then
  [ -n "$output" ] && output="${output}${separator}"
  output="${output}${context_text}"
fi

printf "%s\n" "$output"
[ -n "$usage_text" ] && printf "%s\n" "$usage_text"