{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.apps;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qview
      tutanota-desktop
      obsidian
      slack
      droidcam
      v4l-utils
      xfce.mousepad
    ];

    catppuccin.mpv.enable = false;
    programs = {
      # NOTE: Image viewer
      imv.enable = true;

      # NOTE: Screen recorder
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-vaapi
          droidcam-obs
        ];
      };

      # NOTE: Media player
      mpv = {
        enable = true;
        scripts = with pkgs; [ mpvScripts.uosc mpvScripts.thumbfast ];
        config = {
          osc = "no";
          border = "no";
          sub-font-size = 24;
          sub-border-size = 1;
          hwdec = "auto";
        };
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

    # NOTE: Screenshot utilitiy (disable automatic startup)
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          startupLaunch = false;
          savePath = "${config.home.homeDirectory}/Pictures/screenshots";
          savePathFixed = true;
          useGrimAdapter = true;
          disabledGrimWarning = true;
        };
      };
    };
    systemd.user.services.flameshot.Install.WantedBy = mkForce [ ];

    # NOTE: Enable Syncthing for Obsidian vault synchronization
    services.syncthing = {
      enable = true;
      overrideDevices = false;
      overrideFolders = true;
      settings.folders.obsidianVault = {
        enable = true;
        label = "Obsidian";
        type = "sendreceive";
        path = "${config.home.homeDirectory}/Documents/obsidian";
      };
    };
  };
}
