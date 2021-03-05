#!/bin/bash

set -e -o pipefail


install-elm(){
  curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
  gunzip elm.gz
  chmod +x elm
  sudo mv elm /usr/local/bin/
}

install-elm-test-deps() {
  echo "Installing Elm"
  install-elm
  echo "Installing elm-test"
  npm install elm-test
}

__elm-test() {
  (
  cd elm
  install-elm-test-deps
  node_modules/elm-test/bin/elm-test
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

