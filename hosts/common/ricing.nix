{ pkgs, ... }:

{
  environment.sessionVariables.XKB_DEFAULT_OPTIONS = "caps:swapescape";

  # NOTE: Fonts
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

  # Qt
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };
}
