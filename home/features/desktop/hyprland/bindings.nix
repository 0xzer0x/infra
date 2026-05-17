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

  mod = "SUPER";
  mkBind =
    {
      key,
      action,
      flags ? { },
    }:
    {
      _args = [
        key
        (lib.generators.mkLuaInline action)
        flags
      ];
    };
  mkBindList = bindAttrList: map mkBind bindAttrList;
  workspaceBinds = builtins.concatLists (
    builtins.genList (
      x:
      let
        key = toString (x + 1 - (((x + 1) / 10) * 10));
      in
      mkBindList [
        {
          key = "${mod} + ${key}";
          action = "hl.dsp.focus({ workspace = ${toString (x + 1)} })";
        }
        {
          key = "${mod} + SHIFT + ${key}";
          action = "hl.dsp.window.move({ workspace = ${toString (x + 1)} })";
        }
      ]
    ) 10
  );
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind =
          workspaceBinds
          ++ (mkBindList [
            # ============== Navigation =============== #
            {
              key = "${mod} + H";
              action = ''hl.dsp.focus({ direction = "l" })'';
            }
            {
              key = "${mod} + J";
              action = ''hl.dsp.focus({ direction = "d" })'';
            }
            {
              key = "${mod} + K";
              action = ''hl.dsp.focus({ direction = "u" })'';
            }
            {
              key = "${mod} + L";
              action = ''hl.dsp.focus({ direction = "r" })'';
            }
            {
              key = "${mod} + bracketleft";
              action = ''hl.dsp.window.cycle_next({ next = "prev", tiled = true, floating = true })'';
            }
            {
              key = "${mod} + bracketright";
              action = ''hl.dsp.window.cycle_next({ next = "next", tiled = true, floating = true })'';
            }
            {
              key = "${mod} + SHIFT + H";
              action = ''hl.dsp.window.move({ direction = "l" })'';
            }
            {
              key = "${mod} + SHIFT + J";
              action = ''hl.dsp.window.move({ direction = "d" })'';
            }
            {
              key = "${mod} + SHIFT + K";
              action = ''hl.dsp.window.move({ direction = "u" })'';
            }
            {
              key = "${mod} + SHIFT + L";
              action = ''hl.dsp.window.move({ direction = "r" })'';
            }
            {
              key = "${mod} + mouse:272";
              action = "hl.dsp.window.drag()";
              flags.mouse = true;
            }
            # Special workspace (scratchpad)
            {
              key = "${mod} + S";
              action = ''hl.dsp.workspace.toggle_special("hidden")'';
            }
            {
              key = "${mod} + SHIFT + S";
              action = ''hl.dsp.window.move({ workspace = "special:hidden" })'';
            }
            # Scroll through existing workspaces with mod + scroll
            {
              key = "${mod} + mouse_up";
              action = ''hl.dsp.focus({ workspace = "e-1" })'';
            }
            {
              key = "${mod} + mouse_down";
              action = ''hl.dsp.focus({ workspace = "e+1" })'';
            }
            # ============== Essentials =============== #
            # Terminal
            {
              key = "${mod} + SHIFT + Return";
              action = ''hl.dsp.exec_cmd("${term}")'';
            }
            # Restart Waybar
            {
              key = "${mod} + SHIFT + W";
              action = ''hl.dsp.exec_cmd("${restart-waybar}")'';
            }
            # File manager
            {
              key = "${mod} + T";
              action = ''hl.dsp.exec_cmd("${files}")'';
            }
            # Floating
            {
              key = "${mod} + T";
              action = "hl.dsp.window.float()";
            }
            # Clipboard manager
            {
              key = "${mod} + V";
              action = ''hl.dsp.exec_cmd("${clipboard}")'';
            }
            # Fullscreen
            {
              key = "${mod} + F";
              action = ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'';
            }
            {
              key = "${mod} + SHIFT + F";
              action = ''hl.dsp.window.fullscreen({ mode = "maximized" })'';
            }
            # Lauchers
            {
              key = "${mod} + P";
              action = ''hl.dsp.exec_cmd("${menu}")'';
            }
            {
              key = "${mod} + SHIFT + backspace";
              action = ''hl.dsp.exec_cmd("${powermenu}")'';
            }
            # Screenshot and screenrecording
            {
              key = "Print";
              action = ''hl.dsp.exec_cmd("${screenshot}")'';
            }
            {
              key = "${mod} + Print";
              action = ''hl.dsp.exec_cmd("${screenrec}")'';
            }
            # Emoji picker
            {
              key = "${mod} + period";
              action = ''hl.dsp.exec_cmd("${pickemoji}")'';
            }
            # Password manager
            {
              key = "${mod} + menu";
              action = ''hl.dsp.exec_cmd("${passmenu}")'';
            }
            # Quick password generator
            {
              key = "${mod} + SHIFT + P";
              action = ''hl.dsp.exec_cmd("passgen")'';
            }
            # Quit
            {
              key = "${mod} + Q";
              action = "hl.dsp.window.close()";
            }
            {
              key = "CTRL + ALT + Delete";
              action = "hl.dsp.exit()";
            }
            # ============== Resizing =============== #
            # Equal tile sizes
            {
              key = "CTRL + ${mod} + E";
              action = ''hl.dsp.layout("mfact exact 0.5")'';
            }
            {
              key = "CTRL + ${mod} + H";
              action = "hl.dsp.window.resize({ relative = true, x = -10, y = 0 })";
              flags.repeating = true;
            }
            {
              key = "CTRL + ${mod} + J";
              action = "hl.dsp.window.resize({ relative = true, x = 0, y = 10 })";
              flags.repeating = true;
            }
            {
              key = "CTRL + ${mod} + K";
              action = "hl.dsp.window.resize({ relative = true, x = 0, y = -10 })";
              flags.repeating = true;
            }
            {
              key = "CTRL + ${mod} + L";
              action = "hl.dsp.window.resize({ relative = true, x = 10, y = 0 })";
              flags.repeating = true;
            }
            {
              key = "${mod} + mouse:273";
              action = "hl.dsp.window.resize()";
              flags.mouse = true;
            }
            # ============== Multimedia =============== #
            {
              key = "${mod} + F9";
              action = ''hl.dsp.exec_cmd("${voltoggle}")'';
            }
            {
              key = "XF86AudioMute";
              action = ''hl.dsp.exec_cmd("${voltoggle}")'';
            }
            {
              key = "XF86AudioMicMute";
              action = ''hl.dsp.exec_cmd("${mictoggle}")'';
            }
            {
              key = "${mod} + F10";
              action = ''hl.dsp.exec_cmd("${voldown}")'';
              flags.repeating = true;
            }
            {
              key = "XF86AudioLowerVolume";
              action = ''hl.dsp.exec_cmd("${voldown}")'';
              flags.repeating = true;
            }
            {
              key = "${mod} + F11";
              action = ''hl.dsp.exec_cmd("${volup}")'';
              flags.repeating = true;
            }
            {
              key = "XF86AudioRaiseVolume";
              action = ''hl.dsp.exec_cmd("${volup}")'';
              flags.repeating = true;
            }
            # ============== Submaps =============== #
            {
              key = "${mod} + O";
              action = ''hl.dsp.submap("launch ")'';
            }
          ]);
      };

      submaps = {
        "launch " = {
          settings = {
            bind = mkBindList [
              {
                key = "escape";
                action = ''hl.dsp.submap("reset")'';
              }
              {
                key = "B";
                action = ''
                  function()
                    hl.dispatch(hl.dsp.exec_cmd("${browser}"))
                    hl.dispatch(hl.dsp.submap("reset"))
                  end
                '';
              }
              {
                key = "C";
                action = ''
                  function()
                    hl.dispatch(hl.dsp.exec_cmd("${code}"))
                    hl.dispatch(hl.dsp.submap("reset"))
                  end
                '';
              }
              {
                key = "M";
                action = ''
                  function()
                    hl.dispatch(hl.dsp.exec_cmd("${mousepad}"))
                    hl.dispatch(hl.dsp.submap("reset"))
                  end
                '';
              }
              {
                key = "N";
                action = ''
                  function()
                    hl.dispatch(hl.dsp.exec_cmd("${notes}"))
                    hl.dispatch(hl.dsp.submap("reset"))
                  end
                '';
              }
              {
                key = "S";
                action = ''
                  function()
                    hl.dispatch(hl.dsp.exec_cmd("${slack}"))
                    hl.dispatch(hl.dsp.submap("reset"))
                  end
                '';
              }
              {
                key = "Z";
                action = ''
                  function()
                    hl.dispatch(hl.dsp.exec_cmd("${zathura}"))
                    hl.dispatch(hl.dsp.submap("reset"))
                  end
                '';
              }
            ];
          };
        };
      };
    };
  };
}
