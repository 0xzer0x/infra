{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.breeze
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

    # NOTE: Android debugging utils
    adb.enable = true;

    # NOTE: Libvirt frontend
    virt-manager.enable = true;
  };

  # NOTE: Required for virtual cameras (droidcam, obs)
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  security.polkit.enable = true;
}
