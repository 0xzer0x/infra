{ pkgs }:

let
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
in
pkgs.writeShellScriptBin "passgen" ''
  set -euo pipefail

  ${wl-copy} "$(pwgen -s1y 24)"
  ${notify-send} -i password "Password Generated" "Generated password was copied to clipboard"
''
