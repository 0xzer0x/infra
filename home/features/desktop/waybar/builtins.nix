{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.waybar;
  terminal = config.features.desktop.terminal.default;
  terminalPkg = pkgs.${terminal};
  workspacesCount = 10;
  windowRewriteRules = {
    "format" = "{}";
    "rewrite" = {
      "(.*) — Zen Browser" = "  $1";
      "(.*) - YouTube — Zen Browser" = "  $1";
      "(.*) - mpv" = " $1";
      "~(.*)" = " ";
    };
  };
in
{
  config = mkIf cfg.enable {
    programs.waybar.settings.hyprland-statusbar = {
      "hyprland/window" = windowRewriteRules;
      "hyprland/workspaces" = {
        max-length = workspacesCount;
      };
      "hyprland/submap" = {
        format = "<span style='italic'> {}  </span>";
      };
      "hyprland/language" = {
        format = "{short}";
      };
      keyboard-state = {
        capslock = true;
        format = "󰪛";
        format-icons = {
          locked = "󰪛  ON";
          unlocked = "󰪛  OFF";
        };
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      tray = {
        icon-size = 16;
        spacing = 10;
      };
      clock = {
        interval = 1;
        tooltip = true;
        format = "{:%I:%M %p}";
        format-alt = "{:%a %d %b %I:%M %p}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          mode = "month";
          on-scroll = 1;
          format = {
            months = "<b>{}</b>";
            weekdays = "<b>{}</b>";
            today = "<b><u>{}</u></b>";
          };
        };
        actions = {
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
      cpu = {
        format = "  {usage}% ";
        tooltip = false;
        on-click = "${terminalPkg}/bin/${terminal} -e btop";
      };
      memory = {
        format = "  {}%";
      };
      network = {
        interval = 2;
        format = " {bandwidthDownBytes}  {bandwidthUpBytes}";
        tooltip-format = "{ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "Disconnected ⚠";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };
      disk = {
        interval = 30;
        format = " {free}";
        path = "/";
      };
      pulseaudio = {
        scroll-step = 5;
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "󰖁 {icon} {format_source}";
        format-muted = "󰖁  {format_source}";
        format-source = "󰍬 {volume}%";
        format-source-muted = "󰍭 ";
        format-icons = {
          headphone = " ";
          hands-free = " ";
          headset = " ";
          phone = " ";
          portable = " ";
          car = " ";
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };
        on-click =
          let
            extraTerminalOpts = {
              kitty = "--single-instance --app-id=Wiremix";
            };
          in
          "${terminalPkg}/bin/${terminal} ${extraTerminalOpts.${terminal} or ""} -e wiremix";
      };
    };
  };
}
