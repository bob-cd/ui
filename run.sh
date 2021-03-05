#!/bin/bash

set -e -o pipefail


install-elm-test-deps() {
  echo "Installing Elm"
  npm install elm@latest-0.19.1
  echo "Installing elm-test"
  npm install elm-test
}

__elm-test() {
  (
  cd elm
  install-elm-test-deps
  echo 1
  ls .
  echo 2
  ls node_modules
  echo 3
  ls node_modules/elm-test
  echo 4
  ls node_modules/elm-test/bin
  echo 5
  ls node_modules/elm-test/bin/elm-test
  node_modules/elm-test/bin/elm-test
  node_modules/elm-test/bin/elm-test tests

  rm -r node_modules bin package-lock.json lib
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

