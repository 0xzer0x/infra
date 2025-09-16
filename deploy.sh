#!/usr/bin/env nix
#! nix shell nixpkgs#coreutils nixpkgs#findutils nixpkgs#age nixpkgs#sops nixpkgs#nixos-anywhere --command bash
#/ DESCRIPTION:
#/-
#/ Deploy NixOS configuration to remote hosts using NixOS anywhere.
#/-
#/
#/ USAGE:-
#/   deploy -n|--nixos-configuration NAME -t|--target-host HOST [--master-key-path PATH] [--user-key-spec USERKEY...] [--no-secrets]
#/
#/ SYNOPSIS:
#/   -h|--help: Prints this message.
#/   -n|--nixos-configuration NAME: Name of nixos configuration to deploy to target.
#/   -t|--target-host HOST: SSH username and hostname of server to deploy to (e.g. myuser@myserver).
#/   -m|--master-key-path PATH: Path to secrets master key.
#/   -u|--user-key-spec USERKEY: Path to secret key for a user in the format user=/path/to/keys.txt.
#/   --no-secrets: Skip copying secrets steps to target.

set -euo pipefail

# NOTE: Colors
__STYLE_RESET='\e[0m'
__STYLE_BOLD='\e[1m'
__STYLE_CYAN='\e[36m'
__STYLE_BCYAN='\e[36;1m'
__STYLE_GREEN='\e[32m'
__STYLE_BGREEN='\e[32;1m'
__STYLE_RED='\e[31m'
__STYLE_BRED='\e[31;1m'
__STYLE_YELLOW='\e[33m'
__STYLE_BYELLOW='\e[33;1m'

__OPTION_HELP="0"
__OPTION_NO_SECRETS="0"
__OPTION_TARGET_HOST=""
__OPTION_NIXOS_CONFIGURATION=""
__OPTION_MASTER_KEY_PATH=""
__OPTION_USER_KEY_SPEC=()

__SCRIPT_DIR="$(cd "$(dirname "$(realpath "${0}")")" && pwd)"
__EXTRA_FILES_TMP="$(mktemp -d)"

__errexit() {
  printf "${__STYLE_BRED}error:${__STYLE_RESET}${__STYLE_RED} %s${__STYLE_RESET}\n" "${1}"
  exit 1
}

__log() {
  local _level="${1:-info}"
  _level="${_level^^}"
  local _msg="${2:-}"

  local _level_color="${__STYLE_BOLD}"
  local _msg_color=""
  case "${_level}" in
  INFO)
    _level_color="${__STYLE_BCYAN}"
    _msg_color="${__STYLE_CYAN}"
    ;;
  SUCCESS)
    _level_color="${__STYLE_BGREEN}"
    _msg_color="${__STYLE_GREEN}"
    ;;
  WARN | WARNING)
    _level_color="${__STYLE_BYELLOW}"
    _msg_color="${__STYLE_YELLOW}"
    ;;
  ERROR)
    _level_color="${__STYLE_BRED}"
    _msg_color="${__STYLE_RED}"
    ;;
  esac

  printf "${_level_color}%s, %s:${__STYLE_RESET}${_msg_color} %s${__STYLE_RESET}\n" "$(date '+%F %H:%M:%S')" "${_level}" "${_msg}"
}

__parse_args() {
  while (("${#}")); do
    local __arg="${1:-}"
    local __value="${2:-}"

    case "${__arg}" in
    -h | --help)
      __OPTION_HELP=1
      ;;
    --no-secrets)
      __OPTION_NO_SECRETS=1
      ;;
    -n | --nixos-configuration)
      __OPTION_NIXOS_CONFIGURATION="${__value}"
      shift
      ;;
    -m | --master-key-path)
      __OPTION_MASTER_KEY_PATH="${__value}"
      shift
      ;;
    -t | --target-host)
      __OPTION_TARGET_HOST="${__value}"
      shift
      ;;
    -u | --user-key-spec)
      __OPTION_USER_KEY_SPEC+=("${__value}")
      shift
      ;;
    *)
      __errexit "unexpected option: ${__arg}"
      ;;
    esac

    shift
  done
}

_help() {
  grep '^#/' <"${0}" | cut -c 4-
}

_age_genkey() {
  local _outdir="${1:-${PWD}}"
  age-keygen -o "${_outdir}/keys.txt"
  __log success "Host age key generated at: ${_outdir}/keys.txt"
}

_sops_updatekeys() {
  if [ -z "${__OPTION_MASTER_KEY_PATH}" ]; then
    __errexit "failed to rekey secrets, master key path not specified!"
  fi

  export SOPS_AGE_KEY_FILE="${__OPTION_MASTER_KEY_PATH}"
  find "${__SCRIPT_DIR}/secrets" \( -name "*.yml" -or -name "*.ini" -or -name "*.json" \) -exec sops updatekeys {} \;
  __log success "Secrets updated successfully"
}

_prepare_extra_files() {
  local _confirm_continue="y"

  install -dm755 "${__EXTRA_FILES_TMP}/var/lib/sops-nix"
  _age_genkey "${__EXTRA_FILES_TMP}/var/lib/sops-nix"
  __log info "Copy the new host key to the .sops.yaml file: $(age-keygen -y "${__EXTRA_FILES_TMP}/var/lib/sops-nix/keys.txt")"

  read -rp "Update secrets? [Y/n]: " _confirm_continue
  if [ "${_confirm_continue,,}" = "y" ]; then
    _sops_updatekeys
  fi

  for userkey in "${__OPTION_USER_KEY_SPEC[@]}"; do
    _username="$(cut -d= -f1 <<<"${userkey}")"
    _keypath="$(cut -d= -f2 <<<"${userkey}")"
    install -dm755 "${__EXTRA_FILES_TMP}/home/${_username}/.config/sops/age"
    install -T "${_keypath}" "${__EXTRA_FILES_TMP}/home/${_username}/.config/sops/age/keys.txt"
  done

  __log success "Secret keys are ready for deployment"
}

_deploy() {
  if [ "${__OPTION_NO_SECRETS}" = "0" ]; then
    _prepare_extra_files
  fi

  nixos-anywhere \
    --generate-hardware-config nixos-generate-config "${__SCRIPT_DIR}/hosts/${__OPTION_NIXOS_CONFIGURATION}/hardware.nix" \
    --extra-files "${__EXTRA_FILES_TMP}" \
    --target-host "${__OPTION_TARGET_HOST}" \
    --flake "${__SCRIPT_DIR}#${__OPTION_NIXOS_CONFIGURATION}"
}

_main() {
  if [ "${__OPTION_HELP}" = "1" ]; then
    _help
    exit 0
  fi

  _deploy
}

__parse_args "${@}"
_main
