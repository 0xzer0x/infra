{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Desktop
    hyprland
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    hyprpaper
    hyprshot
    waybar
    swww
    rofi-wayland
    dunst
    wl-clipboard
    wf-recorder
    wlr-randr
    clipman
    weston
    networkmanagerapplet
    adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    adw-gtk3
    nwg-look
    nwg-displays
    papirus-icon-theme
    pavucontrol
    nemo
    nemo-with-extensions
    ffmpegthumbnailer
    vdpauinfo
    libva-vdpau-driver
    libvdpau-va-gl
    mpv
    mpvScripts.uosc
    imv
    qview
    pinentry-qt
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    kdePackages.qt6ct
    kdePackages.breeze
    polkit_gnome
    seahorse
    xdg-utils
    xdg-launch
    xdg-user-dirs
    tutanota-desktop
    obsidian
    catppuccin
    legcord
    slack
    # Programming
    uv
    go
    gnumake
    cmake
    rustup
    python3Full
    nodejs_24
    devbox
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}
