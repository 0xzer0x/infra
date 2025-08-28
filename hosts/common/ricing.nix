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

  # Display manager (greetd + tuigreet)
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet.outPath}/bin/tuigreet -rt --window-padding 3 --theme "text=white;time=lightyellow;container=black;border=darkgray;title=lightmagenta;greet=white;prompt=lightgreen;input=lightred;action=lightblue;button=yellow" -g "Welcome Back" -c Hyprland
        '';
      };
    };
  };

  # Qt
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };
}
