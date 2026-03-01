{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.desktop.fonts;
in
{
  options.features.desktop.fonts.enable = mkEnableOption "Enable better fonts configuration";

  config = mkIf cfg.enable {
    # NOTE: Additional fonts
    home.packages =
      let
        inherit (inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}) sf-pro sf-arabic;
      in
      with pkgs;
      [
        sf-pro
        sf-arabic
        liberation_ttf
        open-sans
        fira-go
        caladea
        carlito
        ubuntu-sans
        amiri
        scheherazade-new
        vazir-fonts
        vazir-code-font
        noto-fonts
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        nerd-fonts.arimo
        nerd-fonts.tinos
        nerd-fonts.cousine
        nerd-fonts.ubuntu
      ];

    fonts.fontconfig = {
      enable = true;
      antialiasing = true;
      hinting = "slight";
      subpixelRendering = "rgb";
      defaultFonts = {
        serif = [
          "Adwaita Sans"
          "SF Arabic"
        ];
        sansSerif = [
          "Adwaita Sans"
          "SF Arabic"
        ];
        monospace = [
          "GeistMono Nerd Font"
          "Vazir Code"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
