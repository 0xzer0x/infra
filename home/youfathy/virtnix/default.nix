{ outputs, ... }:
let
  inherit (outputs.lib) featuresConfiguration;
in
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

  features = featuresConfiguration {
    colorscheme = "catppuccin";
    terminal = "kitty";
    programmingFeatures = [
      "nodejs"
      "python"
      "tools"
    ];
    desktopFeatures = [
      "fonts"
      "gtk"
      "qt"
      "wayland"
      "hyprland"
      "waybar"
      "rofi"
    ];
    cliFeatures = [
      "gnupg"
      "starship"
      "fastfetch"
      "tmux"
      "nvim"
      "yazi"
      "containers"
    ];
  };
}
