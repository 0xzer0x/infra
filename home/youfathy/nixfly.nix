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
      gopass.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
      kitty.enable = true;
      tmux.enable = true;
      nvim.enable = true;
      zsh = {
        enable = true;
        enableFzfIntegration = true;
        enableEzaIntegration = true;
        enableZoxideIntegration = true;
        enableStarshipIntegration = true;
        enableDirEnvIntegration = true;
      };
      k8s.enable = true;
      yazi.enable = true;
    };

    desktop = {
      fonts.enable = true;
      gtk.enable = true;
      qt.enable = true;
      wayland.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      rofi.enable = true;
      apps.enable = true;
    };
  };

  # NOTE: Host-specific configurations
  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-1,1920x1080@60,0x0,1" ",preferred,auto,1,mirror,eDP-1" ];
    binde = [
      ",XF86MonBrightnessUp, exec, brightness inc"
      ",XF86MonBrightnessDown, exec, brightness dec"
    ];
  };

  programs.waybar.settings.hyprland-statusbar = {
    battery = {
      interval = 15;
      bat = "BAT0";
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-charging = " {capacity}%";
      format-icons = [ " " " " " " " " " " ];
      max-length = 100;
    };
    backlight = {
      format = "{icon}  {percent}%";
      format-icons = [ "" "" ];
      max-length = 100;
    };
    modules-right = [
      "network"
      "custom/separator"
      "custom/go-pray"
      "custom/separator"
      "cpu"
      "memory"
      "custom/separator"
      "pulseaudio"
      "custom/separator"
      "backlight"
      "custom/separator"
      "battery"
      "custom/separator"
      "hyprland/language"
      "custom/separator"
      "clock"
      "custom/separator"
      "tray"
    ];
  };
}
