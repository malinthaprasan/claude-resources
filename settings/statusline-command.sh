#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
FIVE_H_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
WEEK=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; GRAY='\033[90m'; RESET='\033[0m'

BAR_COLOR="$GRAY"

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

COST_FMT=$(printf '$%.2f' "$COST")

# Time remaining until 5h rate limit resets
TIME_STR=""
if [ -n "$FIVE_H_RESET" ]; then
  NOW=$(date +%s)
  REMAINING=$((FIVE_H_RESET - NOW))
  [ "$REMAINING" -lt 0 ] && REMAINING=0
  R_H=$((REMAINING / 3600))
  R_M=$(((REMAINING % 3600) / 60))
  TIME_STR="⏱️ ${R_H}h ${R_M}m"
fi

make_bar() {
  local pct=$(printf '%.0f' "$1")
  local len=${2:-10}
  local gray=${3:-0}
  local filled=$((pct * len / 100)); local empty=$((len - filled))
  printf -v f "%${filled}s"; printf -v e "%${empty}s"
  if [ "$gray" -eq 1 ]; then
    local color="$GRAY"
  else
    local color="$GREEN"
    [ "$pct" -ge 70 ] && color="$YELLOW"
    [ "$pct" -ge 90 ] && color="$RED"
  fi
  echo -e "${color}${f// /█}${e// /░}${RESET}"
}

LIMITS=""
[ -n "$FIVE_H" ] && LIMITS="5h:$(make_bar "$FIVE_H")$(printf '%.0f' "$FIVE_H")%"
[ -n "$WEEK" ] && LIMITS="${LIMITS:+$LIMITS }7d:$(make_bar "$WEEK" 5 1)$(printf '%.0f' "$WEEK")%"

echo -e "${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/}"
echo -e "${BAR_COLOR}${BAR}${RESET} ${PCT}% | ${YELLOW}${COST_FMT}${RESET}${TIME_STR:+ | $TIME_STR}${LIMITS:+ | $LIMITS}"
