#!/bin/bash

set -e -o pipefail


ELM_HOME="$(pwd)/elm"

install-elm-test-deps() {
  echo "Installing Elm"
  npm install elm@latest-0.19.1
  echo "Installing elm-test $ELM_HOME"
  npm i -g --prefix ${ELM_HOME} elm-test
}

__elm-test() {
  install-elm-test-deps
  echo "Elm exists?"
  ls "${ELM_HOME}/bin/elm-test"
  cd ${ELM_HOME}
  ./bin/elm-test tests
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

