#!/bin/bash

set -e -o pipefail

install-elm(){
  curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
  gunzip elm.gz
  chmod +x elm
  sudo mv elm /usr/local/bin/
}

install-elm-test-deps() {
  if [ -z $(which elm) ]; then
    echo "Installing Elm"
    install-elm
  else
    echo "Elm already exists"
  fi
  if [ -z $(which elm-test) ]; then
    echo "Installing elm-test"
    npm install elm-test
  else
    echo "elm-test already exists"
    export ELM_TEST_HOME=$(which elm-test)
  fi
}

__elm-test() {
  (
  install-elm-test-deps
  $ELM_TEST_HOME
  )
}

validate_args() {
  acceptable_args="$(declare -F | sed -n "s/declare -f __//p" | tr '\n' ' ')"

  if [[ -z $1 ]]; then
    echo "Must provide an argument" 
    echo -e "Available commands:\n$(declare -F | sed -n "s/declare -f __/ - /p")"
    exit 1
  fi
  if [[ ! " $acceptable_args " =~ .*\ $1\ .* ]]; then
      echo "Invalid argument: $1"
      echo -e "Available commands:\n$(declare -F | sed -n "s/declare -f __/ - /p")"
      exit 1
  fi
}

CMD=${1:-}
shift || true
if validate_args ${CMD}; then
  __${CMD}
  exit 0
fi

