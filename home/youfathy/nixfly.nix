{
  imports = [
    ./home.nix
    ../common
    ../features/cli
    ../features/programming
    ../features/flatpak
    ../features/colorscheme
  ];

  features = {
    colorscheme.active = "catppuccin";
    cli = {
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
  };
}
