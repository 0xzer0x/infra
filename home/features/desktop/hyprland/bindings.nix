{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  inherit (config.xdg) configHome;
  cfg = config.features.desktop.hyprland;
  terminalName = config.features.desktop.terminal.default;
  terminalExtraArgs = if (terminalName == "kitty") then " --single-instance" else "";
  terminal = lib.getExe pkgs.${terminalName};
  term = "${terminal}${terminalExtraArgs}";
  menu = "${lib.getExe pkgs.rofi} -show drun -show-icons";
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
  code = "${term} tmux -N new-session nvim";
  browser = lib.getExe' config.programs.zen-browser.package "zen-beta";
  slack = "${lib.getExe pkgs.slack} --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
  notes = "${lib.getExe pkgs.obsidian} --enable-features=WaylandWindowDecorations";
  mousepad = lib.getExe pkgs.mousepad;
  zathura = lib.getExe pkgs.zathura;
  restart-waybar = "${configHome}/hypr/scripts/restart-waybar";

  workspaceBinds = builtins.concatLists (
    builtins.genList (
      x:
      let
        key = toString (x + 1 - (((x + 1) / 10) * 10));
      in
      [
        "$MOD, ${key}, workspace, ${toString (x + 1)}"
        "$MOD SHIFT, ${key}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        "$MOD" = "SUPER";

        bind = workspaceBinds ++ [
          # ============== Navigation =============== #
          "$MOD, H, movefocus, l"
          "$MOD, J, movefocus, d"
          "$MOD, K, movefocus, u"
          "$MOD, L, movefocus, r"
          "$MOD SHIFT, H, movewindow, l"
          "$MOD SHIFT, J, movewindow, d"
          "$MOD SHIFT, K, movewindow, u"
          "$MOD SHIFT, L, movewindow, r"
          # Special workspace (scratchpad)
          "$MOD, S, togglespecialworkspace, magic"
          "$MOD SHIFT, S, movetoworkspace, special:magic"
          # Scroll through existing workspaces with mod + scroll
          "$MOD, mouse_down, workspace, e+1"
          "$MOD, mouse_up, workspace, e-1"
          # ============== Essentials =============== #
          # Terminal
          "$MOD SHIFT, Return, exec, ${term}"
          # Restart Waybar
          "$MOD SHIFT, W, exec, ${restart-waybar}"
          # File manager
          "$MOD, T, exec, ${files}"
          # Floating
          "$MOD, space, togglefloating,"
          # Clipboard manager
          "$MOD, V, exec, ${clipboard}"
          # Fullscreen
          "$MOD, F, fullscreenstate,3 3"
          "$MOD SHIFT, F, fullscreenstate,0 3"
          # Lauchers
          "$MOD, P, exec, ${menu}"
          "$MOD SHIFT, backspace, exec, ${powermenu}"
          # Screenshot and screenrecording
          ",Print, exec, ${screenshot}"
          "$MOD, Print, exec, ${screenrec}"
          # Emoji picker
          "$MOD, period, exec, ${pickemoji}"
          # Password manager
          "$MOD, menu, exec, ${passmenu}"
          # Quick password generator
          "$MOD SHIFT, P, exec, passgen"
          # Quit
          "$MOD, Q, killactive,"
          "CTRLALT, Delete, exit,"
          # ============== Resizing =============== #
          # Equal tile sizes
          "CTRL_$MOD, E, splitratio, exact 0.5"
          # ============== Multimedia =============== #
          "$MOD, F9, exec, ${voltoggle}"
          ",XF86AudioMute, exec, ${voltoggle}"
          ",XF86AudioMicMute, exec, ${mictoggle}"
          # ============== Submaps =============== #
          "$MOD, O, submap, launch  "
        ];

        binde = [
          # ============== Navigation =============== #
          "$MOD, bracketleft, cyclenext, prev"
          "$MOD, bracketright, cyclenext, next"
          # ============== Multimedia =============== #
          "$MOD, F10, exec, ${voldown}"
          "$MOD, F11, exec, ${volup}"
          ",XF86AudioRaiseVolume, exec, ${volup}"
          ",XF86AudioLowerVolume, exec, ${voldown}"
          # ============== Resizing =============== #
          "CTRL_$MOD, L, resizeactive, 10 0"
          "CTRL_$MOD, H, resizeactive, -10 0"
          "CTRL_$MOD, K, resizeactive, 0 -10"
          "CTRL_$MOD, J, resizeactive, 0 10"
        ];

        bindm = [
          # ============== Navigation =============== #
          # Move/resize windows with mod + LMB/RMB and dragging
          "$MOD, mouse:272, movewindow"
          "$MOD, mouse:273, resizewindow"
        ];
      };

      submaps = {
        "launch  " = {
          settings = {
            bind = [
              "$MOD, O, submap, reset"
              ", escape, submap, reset"
              ", B, exec, ${browser}"
              ", B, submap, reset"
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
