{ pkgs }:

pkgs.writeShellScriptBin "brightness" ''
  #!/usr/bin/env bash
  set -euo pipefail

  HL_CLR="#b4befe"

  notify_level() {
    bright=$(bc <<<"scale=2; (($(brightnessctl get) / $(brightnessctl max))*100)" | cut -d'.' -f1)
    notify-send "Brightness: ''${bright}%" -h string:hlcolor:$HL_CLR -h string:x-dunst-stack-tag:brightnessctl -h int:value:"$bright" --icon="${pkgs.overlayPackages.papirus-icon-theme}/share/icons/Papirus/24x24/symbolic/status/display-brightness-symbolic.svg"
  }

  increment() {
    sudo brightnessctl set +5%
  }

  decrement() {
    sudo brightnessctl set 5%-
  }

  main() {
    case "$1" in
    inc)
      increment
      ;;
    dec)
      decrement
      ;;
    *) ;;
    esac
  }

  main "$@"
  notify_level
''
