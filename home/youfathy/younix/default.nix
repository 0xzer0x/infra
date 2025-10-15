{
  imports = [
    ../home.nix
    ../../common
    ../../features/cli
    ../../features/programming
    ../../features/colorscheme
    ../../features/desktop
    ./virtualization.nix
    ./hyprland.nix
    ./waybar.nix
    ./yazi.nix
    ./gtk.nix
    ./apps.nix
  ];

  features = {
    colorscheme.active = "catppuccin";

    cli = {
      ssh.enable = true;
      git.enable = true;
      gnupg.enable = true;
      gopass.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
      tmux.enable = true;
      nvim.enable = true;
      k8s.enable = true;
      yazi.enable = true;
      go-pray.enable = true;
      aws.enable = true;
      ansible.enable = true;
      multimedia.enable = true;
      containers.enable = true;
      virtualization.enable = true;
      nettools.enable = true;
      rss.enable = true;
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
      apps.enable = true;
    };

    programming = {
      cpp.enable = true;
      go.enable = true;
      rust.enable = true;
      nodejs.enable = true;
      python.enable = true;
      tools.enable = true;
    };
  };
}
