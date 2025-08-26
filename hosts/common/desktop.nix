{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
    libnotify
    weston
    networkmanagerapplet
    papirus-icon-theme
    adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    vdpauinfo
    libva-vdpau-driver
    libvdpau-va-gl
    libappindicator
    mpv
    mpvScripts.uosc
    imv
    qview
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    kdePackages.qt6ct
    kdePackages.breeze
    polkit_gnome
    xdg-utils
    xdg-launch
    xdg-user-dirs
    desktop-file-utils
    tutanota-desktop
    obsidian
    catppuccin
    legcord
    slack
    obs-studio
    droidcam
    v4l-utils
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # NOTE: Libvirt frontend
    virt-manager.enable = true;

    # NOTE: Android debugging utils
    adb.enable = true;

    # NOTE: Enable v4l2loopback for OBS virtual camera
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ wlrobs droidcam-obs obs-vaapi ];
    };
  };

  # NOTE: Enable 2 virtual cameras (droidcam, obs)
  security.polkit.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=0,1 card_label="DroidCam, OBS Cam" exclusive_caps=1
  '';
}
