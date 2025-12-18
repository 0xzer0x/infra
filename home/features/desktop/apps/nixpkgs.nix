{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.apps;
  inherit (config.home) homeDirectory;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice
      signal-desktop
      tutanota-desktop
      obsidian
      legcord
      slack
      droidcam
      v4l-utils
      xfce.mousepad
      qalculate-gtk
      qbittorrent
      kdePackages.kdenlive
      tenacity
      localsend
      bottles
    ];

    # NOTE: Media player
    catppuccin.mpv.enable = false;
    home.sessionVariables = {
      VIDEO = "mpv";
    };
    programs.mpv = {
      enable = true;
      scripts = with pkgs; [
        mpvScripts.uosc
        mpvScripts.thumbfast
      ];
      config = {
        osc = "no";
        border = "no";
        sub-font-size = 24;
        sub-border-size = 1;
        hwdec = "auto";
      };
    };

    programs = {
      # NOTE: Image viewer
      imv = {
        enable = true;
        settings = {
          options.overlay_font = "monospace:10";
          binds = {
            "<Shift+H>" = "prev";
            "<Shift+L>" = "next";
          };
        };
      };

      # NOTE: Screenshot editor used in scripts
      satty = {
        enable = true;
        settings = {
          general = {
            corner-roundness = 0;
            early-exit = true;
            save-after-copy = true;
            actions-on-escape = [ ];
            actions-on-enter = [ "save-to-clipboard" ];
            copy-command = "${pkgs.wl-clipboard}/bin/wl-copy";
            output-filename = "${homeDirectory}/Pictures/screenshots/screenshot_%Y-%m-%d_%H-%M-%S.png";
          };
        };
      };

      # NOTE: Screen recorder
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-vaapi
          droidcam-obs
        ];
      };

      # NOTE: PDF reader
      zathura = {
        enable = true;
        options = {
          recolor = false;
          selection-clipboard = "clipboard";
        };
      };
    };

    # NOTE: Enable Syncthing for Obsidian vault synchronization
    services.syncthing = {
      enable = true;
      settings = {
        devices = {
          phone = {
            id = "4EBCMTO-XYQYAVB-X4XHTMW-J3GALVG-C7UWCJA-LVTI5HO-LGXK7GM-2ZE2PAZ";
            name = "Phone";
          };
        };

        folders.obsidianVault = {
          enable = true;
          label = "Obsidian";
          type = "sendreceive";
          path = "${homeDirectory}/Documents/obsidian";
          devices = [ "phone" ];
        };
      };
    };

    # NOTE: Scratchpad
    xdg.configFile."Mousepad/settings.conf" = {
      force = true;
      text = ''
        [org/xfce/mousepad/preferences/window]
        menubar-visible=false

        [org/xfce/mousepad/preferences/view]
        color-scheme='catppuccin-mocha-blue'
        use-default-monospace-font=false
        font-name='monospace 11'
        show-line-numbers=true
        word-wrap=true
      '';
    };
  };
}
