{ outputs, ... }:
let inherit (outputs.lib) featuresConfiguration;
in {
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

  features = featuresConfiguration {
    colorscheme = "catppuccin";
    terminal = "kitty";
    # NOTE: Enabled features
    programmingFeatures = [ "cpp" "go" "rust" "nodejs" "python" "tools" ];
    desktopFeatures =
      [ "fonts" "gtk" "qt" "wayland" "hyprland" "waybar" "rofi" "apps" ];
    cliFeatures = [
      "ssh"
      "git"
      "gnupg"
      "gopass"
      "starship"
      "fastfetch"
      "tmux"
      "nvim"
      "k8s"
      "yazi"
      "aws"
      "ansible"
      "multimedia"
      "containers"
      "virtualization"
      "nettools"
      "go-pray"
      "rss"
    ];
  };
}
