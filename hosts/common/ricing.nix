{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle,caps:swapescape";
  };

  # Fonts
  environment.systemPackages = with pkgs; [ fontconfig ];
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      adwaita-fonts
      noto-fonts
      open-sans
      ubuntu-sans
      nerd-fonts.geist-mono
      nerd-fonts.ubuntu
      corefonts
      vista-fonts
    ];

    fontconfig = {
      enable = true;
      includeUserConf = true;
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = [ "Open Sans" "SF Arabic" ];
        sansSerif = [ "Open Sans" "SF Arabic" ];
        monospace = [ "GeistMono Nerd Font" "SF Arabic" ];
      };
    };
  };

  # Display manager (greetd + regreet)
  programs.regreet = {
    enable = true;
    package = pkgs.regreet;
    extraCss = ./etc/greetd/regreet.css;
    cageArgs = [ "-s" "-m" "last" ];
    settings = { GTK.application_prefer_dark_theme = true; };

    font = {
      package = pkgs.open-sans;
      name = "Open Sans";
      size = 10;
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  # Qt
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };
}
