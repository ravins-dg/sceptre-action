#!/bin/bash

function parseInputs {
  # Required inputs
  if [[ "${INPUT_SCEPTRE_SUBCOMMAND}" != "" ]]; then
    sceptreSubcommand=${INPUT_SCEPTRE_SUBCOMMAND}
  else
    echo "Input sceptre_subcommand cannot be empty!"
    exit 1
  fi

  # Optional inputs
  sceptreVer='2.5.0'
  if [[ "${INPUT_SCEPTRE_VERSION}" != "" ]]; then
    if [[ "${INPUT_SCEPTRE_VERSION}" =~ ^2[.][0-9][.][0-9]$ ]]; then
      sceptreVer=${INPUT_SCEPTRE_VERSION}
    else
      echo "Unsupported sceptre version"
      exit 1
    fi
  else
    echo "Input sceptre_version cannot be empty!"
    exit 1
  fi

  sceptreDir="."
  if [[ -n "${INPUT_SCEPTRE_DIRECTORY}" ]]; then
    sceptreDir=${INPUT_SCEPTRE_DIRECTORY}
  fi

}

function installDeps {
  echo "Installing Sceptre"
  pip install --no-input sceptre==$sceptreVer
}


function main {
  parseInputs
  installDeps

  cd ${GITHUB_WORKSPACE}/${sceptreDir}

  sceptre $sceptreSubcommand
}

main "${*}"
