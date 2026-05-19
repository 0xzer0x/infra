{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.features.desktop.hyprland;
in
{
  options.features.desktop.hyprland.animations.enable = mkOption {
    description = "Enable hyprland animations configuration";
    type = lib.types.bool;
    default = false;
  };

  # NOTE: Animations
  # Ref:
  # - https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
  # - https://github.com/HyDE-Project/HyDE/blob/master/Configs/.config/hypr/animations/fast.conf
  config.wayland.windowManager.hyprland.settings = mkIf cfg.animations.enable {
    curve = [
      {
        _args = [
          "linear"
          {
            type = "bezier";
            points = [
              [
                0
                0
              ]
              [
                1
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "md3_decel"
          {
            type = "bezier";
            points = [
              [
                0.05
                0.7
              ]
              [
                0.1
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "ease_out_expo"
          {
            type = "bezier";
            points = [
              [
                0.16
                1
              ]
              [
                0.3
                1
              ]
            ];
          }
        ];
      }
    ];

    animation = [
      {
        enabled = true;
        leaf = "windows";
        speed = 2;
        bezier = "md3_decel";
        style = "popin 60%";
      }
      {
        enabled = true;
        leaf = "border";
        speed = 2;
        bezier = "default";
      }
      {
        enabled = true;
        leaf = "fade";
        speed = 2;
        bezier = "md3_decel";
      }
      {
        enabled = true;
        leaf = "workspaces";
        speed = 2;
        bezier = "ease_out_expo";
        style = "slide";
      }
      {
        enabled = true;
        leaf = "specialWorkspace";
        speed = 2;
        bezier = "md3_decel";
        style = "slidevert";
      }
    ];
  };
}
