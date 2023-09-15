#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

function debug {
  if [ "$DEBUG" == "1" ]; then
    echo -e "🐞  ${CYAN}Debug:${NC} $1"
  fi
}

function loading {
  echo -e "🔌  ${YELLOW}Loading:${NC} $1..."
}


function info {
  echo -e "🪵  ${PURPLE}Info:${NC} $1"
}

function error {
  echo -e "⛔️  ${RED}Error:${NC} $1" >&2
}

function clear_previous_line {
  tput cuu 1
  tput el
}
