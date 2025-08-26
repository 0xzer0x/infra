{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.features.desktop.waybar;
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
in {
  config = mkIf cfg.enable {
    programs.waybar.settings = {
      "hyprland/window" = windowRewriteRules;
      "hyprland/workspaces" = { "max-length" = workspacesCount; };
      "hyprland/submap" = { "format" = "<span style='italic'> {}  </span>"; };
      "hyprland/language" = { "format" = "{short}"; };
      "sway/window" = windowRewriteRules;
      "dwl/window" = windowRewriteRules;
      "dwl/tags" = { "num-tags" = workspacesCount - 1; };
      "keyboard-state" = {
        "capslock" = true;
        "format" = "󰪛";
        "format-icons" = {
          "locked" = "󰪛  ON";
          "unlocked" = "󰪛  OFF";
        };
      };
      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
      };
      "tray" = {
        "icon-size" = 16;
        "spacing" = 10;
      };
      "clock" = {
        "interval" = 1;
        "tooltip" = false;
        "format" = "{:%a %d %b %I:%M %p}";
        "format-alt" = "{:%F %T}";
        "tooltip-format" = ''
          <big>{:%Y %B}</big>
          <tt>{calendar}</tt>
        '';
      };
      "cpu" = {
        "format" = "  {usage}% ";
        "tooltip" = false;
        "on-click" = "${pkgs.kitty.outPath}/bin/kitty -e btop";
      };
      "memory" = { "format" = "  {}%"; };
      "network" = {
        "interval" = 2;
        "format" = " {bandwidthDownBytes}  {bandwidthUpBytes}";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
      };
      "disk" = {
        "interval" = 30;
        "format" = " {free}";
        "path" = "/";
      };
      "pulseaudio" = {
        "scroll-step" = 5;
        "on-click" = "${pkgs.pavucontrol.outPath}/bin/pavucontrol";
        "format" = "{icon} {volume}% {format_source}";
        "format-bluetooth" = "{volume}% {icon} {format_source}";
        "format-bluetooth-muted" = "󰖁 {icon} {format_source}";
        "format-muted" = "󰖁  {format_source}";
        "format-source" = "󰍬 {volume}%";
        "format-source-muted" = "󰍭 ";
        "format-icons" = {
          "headphone" = " ";
          "hands-free" = " ";
          "headset" = " ";
          "phone" = " ";
          "portable" = " ";
          "car" = " ";
          "default" = [ "󰕿" "󰖀" "󰕾" ];
        };
      };
    };
  };
}
