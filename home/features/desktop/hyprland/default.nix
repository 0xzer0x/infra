{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.hyprland;
  # WARN: Must not contain shell expansion syntax (raw strings only)
  environmentVariables = {
    inherit (config.home.sessionVariables)
      XDG_CONFIG_HOME
      XDG_DATA_HOME
      XDG_CACHE_HOME
      XDG_STATE_HOME
      XDG_DOCUMENTS_DIR
      XDG_DOWNLOAD_DIR
      XDG_MUSIC_DIR
      XDG_DESKTOP_DIR
      XDG_PICTURES_DIR
      XDG_TEMPLATES_DIR
      XDG_VIDEOS_DIR
      XDG_PUBLICSHARE_DIR
      # NOTE: Wayland
      NIXOS_OZONE_WL
      ELECTRON_OZONE_PLATFORM_HINT
      GDK_BACKEND
      GDK_SCALE
      # NOTE: Qt
      QT_QPA_PLATFORM
      QT_QPA_PLATFORMTHEME
      QT_STYLE_OVERRIDE
      QT_WAYLAND_DISABLE_WINDOWDECORATION
      # NOTE: Misc
      GNUPGHOME
      VIDEO
      EDITOR
      ;
    # NOTE: Hyprland
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = 22;
    HYPRCURSOR_THEME = "Adwaita";
    HYPRCURSOR_SIZE = 22;
  };
in
{
  options.features.desktop.hyprland.enable = mkEnableOption "Enable Hyprland desktop configuration";

  imports = [
    ./packages.nix
    ./bindings.nix
    ./rules.nix
    ./xdph.nix
  ];

  config = mkIf cfg.enable {
    xdg.configFile = {
      "hypr/scripts" = {
        enable = true;
        source = ./scripts;
        recursive = true;
      };
      "hypr/wall.png" = {
        enable = true;
        source = ./wall.png;
      };
    };

    catppuccin.hyprland.enable = false;
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = null;
      portalPackage = null;
      systemd.variables = [ "--all" ];
      configType = "lua";

      settings = {
        # NOTE: Configuration variables
        # Ref: https://wiki.hypr.land/Configuring/Basics/Variables/
        config = {
          # NOTE: Layouts
          general = {
            gaps_in = 0;
            gaps_out = 0;
            border_size = 2;
            allow_tearing = false;
            layout = "master";
            col = {
              active_border = "rgb(89b4fa)";
              inactive_border = "rgb(45475a)";
            };
          };

          # NOTE: Master layout
          master = {
            new_status = "slave";
            mfact = 0.5;
          };

          # NOTE: Look and feel
          cursor.sync_gsettings_theme = true;
          decoration.rounding = 0;

          # NOTE: Input methods
          input = {
            kb_layout = "us,ara";
            kb_model = "pc105";
            kb_options = "grp:alt_shift_toggle,caps:swapescape";

            sensitivity = 0;
            follow_mouse = 1;
            natural_scroll = false;
            touchpad.natural_scroll = true;
          };

          # NOTE: Misc
          ecosystem.no_donation_nag = true;
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };
        };

        # NOTE: Environment variables (imported session variables and add additional ones)
        env = lib.attrsets.mapAttrsToList (name: value: {
          _args = [
            name
            (toString value)
          ];
        }) environmentVariables;

        # NOTE: Animations
        # Ref:
        # - https://github.com/HyDE-Project/HyDE/blob/master/Configs/.config/hypr/animations/fast.conf
        # - https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
        curve = [
          {
            _args = [
              "linear"
              {
                type = "bezier";
                points = [
                  [
                    0
                    0
                  ]
                  [
                    1
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "md3_decel"
              {
                type = "bezier";
                points = [
                  [
                    0.05
                    0.7
                  ]
                  [
                    0.1
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "ease_out_expo"
              {
                type = "bezier";
                points = [
                  [
                    0.16
                    1
                  ]
                  [
                    0.3
                    1
                  ]
                ];
              }
            ];
          }
        ];
        animation = [
          {
            enabled = true;
            leaf = "windows";
            speed = 2;
            bezier = "md3_decel";
            style = "popin 60%";
          }
          {
            enabled = true;
            leaf = "border";
            speed = 2;
            bezier = "default";
          }
          {
            enabled = true;
            leaf = "fade";
            speed = 2;
            bezier = "md3_decel";
          }
          {
            enabled = true;
            leaf = "workspaces";
            speed = 2;
            bezier = "ease_out_expo";
            style = "slide";
          }
          {
            enabled = true;
            leaf = "specialWorkspace";
            speed = 2;
            bezier = "md3_decel";
            style = "slidevert";
          }
        ];

        # NOTE: Auto-start
        on = [
          {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("${config.xdg.configHome}/hypr/scripts/wallpaper")
                  hl.exec_cmd("${pkgs.wl-clipboard}/bin/wl-paste -t text --watch clipman store --max-items=50 --no-persist")
                end
              '')
            ];
          }
        ];
      };
    };
  };
}
