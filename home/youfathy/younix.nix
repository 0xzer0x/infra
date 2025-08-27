{
  imports = [
    ./home.nix
    ../common
    ../features/cli
    ../features/programming
    ../features/colorscheme
    ../features/desktop
  ];

  features = {
    colorscheme.active = "catppuccin";
    cli = {
      git.enable = true;
      gnupg.enable = true;
      starship.enable = true;
      zsh = {
        enable = true;
        enableFzfIntegration = true;
        enableEzaIntegration = true;
        enableZoxideIntegration = true;
        enableStarshipIntegration = true;
        enableDirEnvIntegration = true;
      };
    };

    desktop = {
      fonts.enable = true;
      wayland.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      rofi.enable = true;
      apps.enable = true;
    };
  };

  # NOTE: Host-specific configurations
  wayland.windowManager.hyprland.settings.monitor =
    [ "DP-1,1920x1080@144,0x0,1" ",preferred,auto,1,mirror,DP-1" ];
}
