{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.enable =
    mkEnableOption "Enable Hyprland desktop configuration";

  imports = [ ./packages.nix ./bindings.nix ./rules.nix ./xdph.nix ];

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

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = null;
      portalPackage = null;
      systemd.variables = [ "--all" ];

      settings = {
        # NOTE: Layouts
        general = {
          gaps_in = 2;
          gaps_out = 2;
          border_size = 2;
          "col.active_border" = "$blue";
          "col.inactive_border" = "$surface1";
          layout = "master";
          allow_tearing = false;
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "slave";
          mfact = 0.5;
        };

        # NOTE: Misc
        ecosystem.no_donation_nag = true;
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          disable_hyprland_qtutils_check = true;
        };

        # NOTE: Environment variables
        env = [
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XCURSOR_THEME,Adwaita"
          "XCURSOR_SIZE,22"
          "HYPRCURSOR_THEME,Adwaita"
          "HYPRCURSOR_SIZE,22"
        ];

        # NOTE: Look and feel
        cursor.sync_gsettings_theme = true;
        decoration.rounding = 6;
        # NOTE: Fast animations
        # Ref: https://github.com/HyDE-Project/HyDE/blob/master/Configs/.config/hypr/animations/fast.conf
        animations = {
          enabled = true;
          bezier = [
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92"
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "fluent_decel, 0.1, 1, 0, 1"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
          ];
          animation = [
            "windows, 1, 3, md3_decel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 2.5, md3_decel"
            "workspaces, 1, 3.5, easeOutExpo, slide"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];
        };

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

        # NOTE: Auto-start
        exec-once = [
          "${config.xdg.configHome}/hypr/scripts/wallpaper"
          "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch clipman store --max-items=50 --no-persist"
        ];
      };
    };
  };
}
