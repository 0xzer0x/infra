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
      zsh.enable = true;
      gopass.enable = false;
      aws.enable = false;
      ansible.enable = false;
      multimedia.enable = false;
      git.enable = false;
      gnupg.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
      tmux.enable = true;
      nvim.enable = true;
      k8s.enable = true;
      yazi.enable = true;
      go-pray.enable = true;
      containers.enable = true;
      virtualization.enable = false;
    };

    desktop = {
      terminal.default = "kitty";
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
