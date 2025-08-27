{ pkgs }:

pkgs.writeShellScriptBin "passgen" ''
  #!/usr/bin/env bash
  set -euo pipefail

  wl-copy "$(pwgen -s1y 24)"
  notify-send -i password "Password Generated" "Generated password was copied to clipboard"
''
