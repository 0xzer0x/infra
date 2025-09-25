{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.fonts;
in {
  options.features.desktop.fonts.enable =
    mkEnableOption "Enable better fonts configuration";

  config = mkIf cfg.enable {
    # NOTE: Additional fonts
    home.packages = with pkgs; [
      liberation_ttf
      fira-go
      caladea
      carlito
      ubuntu-sans
      amiri
      scheherazade-new
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.arimo
      nerd-fonts.tinos
      nerd-fonts.cousine
      nerd-fonts.ubuntu
    ];

    # NOTE: Custom Arabic font
    xdg.dataFile."fonts/SF-Arabic" = {
      source = ./SF-Arabic;
      recursive = true;
    };

    # NOTE: Monospace Arabic font
    xdg.dataFile."fonts/Kawkab-Mono" = {
      source = ./Kawkab-Mono;
      recursive = true;
    };

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Adwaita Sans" "SF Arabic" ];
        sansSerif = [ "Adwaita Sans" "SF Arabic" ];
        monospace = [ "GeistMono Nerd Font" "SF Arabic" ];
      };
    };
  };
}
