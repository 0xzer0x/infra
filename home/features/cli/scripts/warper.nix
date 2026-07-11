{ lib, pkgs }:

let
  warp-cli = lib.getExe' pkgs.cloudflare-warp "warp-cli";
  notify-send = lib.getExe' pkgs.libnotify "notify-send";
in
pkgs.writeShellScriptBin "warper" ''
  set -euo pipefail

  __WARP_STATE=""
  declare -A __STATE_ICONS=(
    [connecting]=network-vpn
    [connected]=network-vpn
    [disconnected]=internet-archive
  )

  # NOTE: Possible values: on, off, toggle
  __ARGUMENT_STATE="''${1:-toggle}"

  _current_warp_state() {
    local _state="$(${warp-cli} status | head -n 1 | cut -d':' -f2 | tr -d '[:space:]')"
    printf "%s" "''${_state,,}"
  }

  _notify_state() {
    ${notify-send} -h string:x-dunst-stack-tag:warper -i "''${__STATE_ICONS["''${__WARP_STATE}"]}" "Cloudflare WARP: ''${__WARP_STATE}"
  }

  _main() {
    case "''${__ARGUMENT_STATE}" in
    on)
      ${warp-cli} connect
      ;;
    off)
      ${warp-cli} disconnect
      ;;
    toggle)
      local _old_state="$(_current_warp_state)"
      if [ "''${_old_state}" = "connected" ]; then
        ${warp-cli} disconnect
      else
        ${warp-cli} connect
      fi
      ;;
    *)
      echo "Usage: ''${0} [on|off|toggle]"
      exit 1
      ;;
    esac

    __WARP_STATE="$(_current_warp_state)"
    _notify_state
  }

  _main
''
