{ pkgs, ... }:

{
  # NOTE: Fonts
  environment.systemPackages = with pkgs; [ fontconfig ];
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      adwaita-fonts
      noto-fonts
      nerd-fonts.geist-mono
      nerd-fonts.liberation
    ];

    fontconfig = {
      enable = true;
      includeUserConf = true;
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = [ "Adwaita Sans" ];
        sansSerif = [ "Adwaita Sans" ];
        monospace = [ "GeistMono Nerd Font" ];
      };
    };
  };
}
