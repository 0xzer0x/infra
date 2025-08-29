{ config, ... }:

{
  additions = final: prev:
    let colorscheme = config.features.colorscheme.active;
    in {
      overlayPackages.papirus-icon-theme = if (colorscheme == "catppuccin") then
        prev.catppuccin-papirus-folders
      else
        prev.papirus-icon-theme;
    };
}
