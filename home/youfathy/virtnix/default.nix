{
  imports = [
    ../home.nix
    ../../common
    ../../features/cli
    ../../features/programming
    ../../features/colorscheme
    ../../features/desktop
    ./hyprland.nix
    ./waybar.nix
  ];

  features = {
    colorscheme.active = "catppuccin";

    cli = {
      zsh = {
        enable = true;
        enableFzfIntegration = true;
        enableEzaIntegration = true;
        enableZoxideIntegration = true;
        enableStarshipIntegration = true;
        enableDirEnvIntegration = true;
      };

      git.enable = true;
      gnupg.enable = true;
      gopass.enable = false;
      starship.enable = true;
      fastfetch.enable = true;
      kitty.enable = true;
      tmux.enable = true;
      nvim.enable = true;
      k8s.enable = true;
      yazi.enable = true;
      go-pray.enable = true;
    };

    desktop = {
      fonts.enable = true;
      gtk.enable = true;
      qt.enable = true;
      wayland.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      rofi.enable = true;
      apps.enable = false;
    };

    programming = {
      cpp.enable = false;
      rust.enable = false;
      go.enable = false;
      nodejs.enable = true;
      python.enable = true;
      tools.enable = true;
    };
  };
}
