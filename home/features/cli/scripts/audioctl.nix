{ pkgs }:

let
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  grep = "${pkgs.gnugrep}/bin/grep";
in pkgs.writeShellScriptBin "audioctl" ''
  set -euo pipefail

  declare -A __MUTE_ICONS=(
    [@DEFAULT_SINK@]=audio-volume-muted-symbolic
    [@DEFAULT_SOURCE@]=audio-input-microphone-muted-symbolic
  )

  declare -A __ACTIVE_ICONS=(
    [@DEFAULT_SINK@]=audio-volume-high-symbolic
    [@DEFAULT_SOURCE@]=audio-input-microphone-high-symbolic
  )

  __HL_CLR="#b4befe"
  _DEVICE=""

  __audio-percentage() {
    local __level
    __level="$(${wpctl} get-volume "''${_DEVICE}")"
    if [[ "$__level" == "Volume: 1.00" ]]; then
      __level="100"
    else
      __level="$(echo "$__level" | cut -d'.' -f2)"
    fi

    echo "$__level"
  }

  _notify-audio-level() {
    local __percent
    __percent=$(__audio-percentage)
    ${notify-send} "Audio: ''${__percent}%" -h string:x-dunst-stack-tag:audioctl -h "int:value:$__percent" -h "string:hlcolor:$__HL_CLR" --icon="''${__ACTIVE_ICONS["''${_DEVICE}"]}"
  }

  _notify-mute-state() {
    local __state
    local __icon
    local __title

    if ${grep} -q MUTED < <(${wpctl} get-volume "''${_DEVICE}"); then
      __icon="''${__MUTE_ICONS["''${_DEVICE}"]}"
      __title="Audio: MUTED"
    else
      __icon="''${__ACTIVE_ICONS["''${_DEVICE}"]}"
      __title="Audio: $(__audio-percentage)%"
    fi

    ${notify-send} "''${__title}" -h string:x-dunst-stack-tag:audioctl --icon="''${__icon}"
  }

  case "''${1}" in
    source)
      _DEVICE="@DEFAULT_SOURCE@"
      ;;
    sink)
      _DEVICE="@DEFAULT_SINK@"
      ;;
    *)
      printf "unknown device: %s\n" "''${1}"
      exit 1
  esac

  case "''${2}" in
    inc)
      ${wpctl} set-volume -l 1.0 "''${_DEVICE}" 5%+
      _notify-audio-level
      ;;
    dec)
      ${wpctl} set-volume -l 0.0 "''${_DEVICE}" 5%-
      _notify-audio-level
      ;;
    toggle)
      ${wpctl} set-mute "''${_DEVICE}" toggle
      _notify-mute-state
      ;;
    *)
      if ${grep} -q MUTED < <(${wpctl} get-volume @DEFAULT_SINK@); then
        echo "MUTED"
      else
        echo "$(__audio-percentage)%"
      fi
      ;;
  esac
''
