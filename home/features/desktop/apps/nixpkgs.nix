{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.apps;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      imv
      qview
      mpv
      mpvScripts.uosc
      tutanota-desktop
      obsidian
      legcord
      slack
      droidcam
      v4l-utils
    ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ wlrobs obs-vaapi droidcam-obs ];
    };

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
