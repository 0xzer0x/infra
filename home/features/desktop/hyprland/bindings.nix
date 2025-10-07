{ config, lib, pkgs, ... }:

with lib;
let
  inherit (config.xdg) configHome;
  cfg = config.features.desktop.hyprland;
  terminal = config.features.desktop.terminal.default;
  terminalPkg = pkgs.${terminal};
  term = "${terminalPkg}/bin/${terminal}"
    + (if (terminal == "kitty") then " --single-instance" else "");
  menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons";
  passmenu = "${configHome}/rofi/runners/passmenu";
  powermenu = "${configHome}/rofi/runners/powermenu";
  clipboard = "${configHome}/rofi/runners/clipboard";
  screenshot = "${configHome}/rofi/runners/screenshot";
  screenrec = "${configHome}/rofi/runners/screenrec";
  pickemoji = "${configHome}/rofi/runners/pickemoji";
  volup = "audioctl sink inc";
  voldown = "audioctl sink dec";
  voltoggle = "audioctl sink toggle";
  mictoggle = "audioctl source toggle";
  files = "${term} yazi";
  code = "${term} tmux new nvim";
  browser = "flatpak run app.zen_browser.zen";
  telegram = "flatpak run org.telegram.desktop";
  slack =
    "${pkgs.slack}/bin/slack --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
  notes =
    "${pkgs.obsidian}/bin/obsidian --enable-features=WaylandWindowDecorations";
  mousepad = "${pkgs.xfce.mousepad}/bin/mousepad";
  zathura = "${pkgs.zathura}/bin/zathura";
  restart-waybar = "${configHome}/hypr/scripts/restart-waybar";

  workspaceBinds = builtins.concatLists (builtins.genList (x:
    let key = builtins.toString (x + 1 - (((x + 1) / 10) * 10));
    in [
      "$mod, ${key}, workspace, ${toString (x + 1)}"
      "$mod SHIFT, ${key}, movetoworkspace, ${toString (x + 1)}"
    ]) 10);
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        general = { "$mod" = "SUPER"; };

        bind = workspaceBinds ++ [
          # ============== Navigation =============== #
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, L, movewindow, r"
          # Special workspace (scratchpad)
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
          # Scroll through existing workspaces with mod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          # ============== Essentials =============== #
          # Terminal
          "$mod SHIFT, Return, exec, ${term}"
          # Restart Waybar
          "$mod SHIFT, W, exec, ${restart-waybar}"
          # File manager
          "$mod, T, exec, ${files}"
          # Floating
          "$mod, space, togglefloating,"
          # Clipboard manager
          "$mod, V, exec, ${clipboard}"
          # Fullscreen
          "$mod, F, fullscreenstate,3 3"
          "$mod SHIFT, F, fullscreenstate,0 3"
          # Lauchers
          "$mod, P, exec, ${menu}"
          "$mod SHIFT, backspace, exec, ${powermenu}"
          # Screenshot and screenrecording
          ",Print, exec, ${screenshot}"
          "$mod,Print, exec, ${screenrec}"
          # Emoji picker
          "$mod, period, exec, ${pickemoji}"
          # Password manager
          "$mod, menu, exec, ${passmenu}"
          # Quick password generator
          "$mod SHIFT, P, exec, passgen"
          # Quit
          "$mod, Q, killactive,"
          "CTRLALT, Delete, exit,"
          # ============== Resizing =============== #
          # Equal tile sizes
          "CTRL_$mod, E, splitratio, exact 0.5"
          # ============== Multimedia =============== #
          "$mod, F9, exec, ${voltoggle}"
          ",XF86AudioMute, exec, ${voltoggle}"
          ",XF86AudioMicMute, exec, ${mictoggle}"
          # ============== Submaps =============== #
          "$mod, O, submap, launch  "
        ];

        binde = [
          # ============== Navigation =============== #
          "$mod, bracketleft, cyclenext, prev"
          "$mod, bracketright, cyclenext, next"
          # ============== Multimedia =============== #
          "$mod, F10, exec, ${voldown}"
          "$mod, F11, exec, ${volup}"
          ",XF86AudioRaiseVolume, exec, ${volup}"
          ",XF86AudioLowerVolume, exec, ${voldown}"
          # ============== Resizing =============== #
          "CTRL_$mod, L, resizeactive, 10 0"
          "CTRL_$mod, H, resizeactive, -10 0"
          "CTRL_$mod, K, resizeactive, 0 -10"
          "CTRL_$mod, J, resizeactive, 0 10"
        ];

        bindm = [
          # ============== Navigation =============== #
          # Move/resize windows with mod + LMB/RMB and dragging
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };

      submaps = {
        "launch  " = {
          settings = {
            bind = [
              "$mod, O, submap, reset"
              ", escape, submap, reset"
              ", B, exec, ${browser}"
              ", B, submap, reset"
              ", T, exec, ${telegram}"
              ", T, submap, reset"
              ", C, exec, ${code}"
              ", C, submap, reset"
              ", M, exec, ${mousepad}"
              ", M, submap, reset"
              ", N, exec, ${notes}"
              ", N, submap, reset"
              ", S, exec, ${slack}"
              ", S, submap, reset"
              ", Z, exec, ${zathura}"
              ", Z, submap, reset"
            ];
          };
        };
      };
    };
  };
}
