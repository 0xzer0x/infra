{ pkgs, ... }:

{
  # NOTE: Fonts
  environment.systemPackages = with pkgs; [ fontconfig ];
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [ adwaita-fonts nerd-fonts.geist-mono ];
    fontconfig = {
      enable = true;
      includeUserConf = true;
      subpixel.rgba = "rgb";
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Adwaita Sans" ];
        sansSerif = [ "Adwaita Sans" ];
        monospace = [ "GeistMono Nerd Font" ];
      };
    };
  };
}
