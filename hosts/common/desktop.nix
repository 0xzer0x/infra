{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
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
  };

  # NOTE: Enable swaylock PAM authentication
  security.pam.services.swaylock = { };

  security.polkit.enable = true;

  # FIX: https://github.com/NixOS/nixpkgs/issues/576406
  boot.extraModulePackages =
    let
      v4l2loopback-workaround = pkgs.runCommand "v4l2loopback-workaround" { } ''
        subdir=lib/modules/${config.boot.kernelPackages.kernel.version}
        mkdir -p $out/$subdir
        cd ${config.boot.kernelPackages.v4l2loopback}
        for f in *; do
          if [[ $f =~ ^modules ]]; then continue; fi
          cp -r $f $out/$subdir/$f
        done
      '';
    in
    [ v4l2loopback-workaround ];

  # NOTE: Required for virtual cameras (droidcam - /dev/video0, obs - /dev/video1)
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=0,1 card_label="DroidCam,OBSCam" exclusive_caps=1,1
  '';
}
