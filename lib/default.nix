{ ... }:

let
  # NOTE: User environment helper utilities
  enableFeatures =
    features:
    builtins.listToAttrs (
      builtins.map (name: {
        inherit name;
        value = {
          enable = true;
        };
      }) features
    );

  desktopConfiguration =
    { features, terminal }:
    (enableFeatures features)
    // {
      terminal.default = terminal;
    };

  featuresConfiguration =
    {
      colorscheme,
      terminal,
      cliFeatures,
      desktopFeatures,
      programmingFeatures,
    }:
    {
      colorscheme.active = colorscheme;
      cli = enableFeatures cliFeatures;
      programming = enableFeatures programmingFeatures;
      desktop = desktopConfiguration {
        inherit terminal;
        features = desktopFeatures;
      };
    };
in
{
  inherit enableFeatures desktopConfiguration featuresConfiguration;
}
