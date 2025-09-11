{ pkgs }:

pkgs.writeShellScriptBin "brightness" ''
  #!/usr/bin/env bash
  set -euo pipefail

  _notify_level() {
    local _brightness
    _brightness="$(bc <<<"scale=2; (($(brightnessctl get) / $(brightnessctl max))*100)" | cut -d'.' -f1)"
    notify-send "Brightness: ''${_brightness}%" -h string:x-dunst-stack-tag:brightnessctl -h int:value:"''${_brightness}" -i display-brightness"
  }

  _increment() {
    sudo brightnessctl set +5%
  }

  _decrement() {
    sudo brightnessctl set 5%-
  }

  _main() {
    case "$1" in
    inc)
      _increment
      ;;
    dec)
      _decrement
      ;;
    *) ;;
    esac
  }

  _main "$@"
  _notify_level
''
