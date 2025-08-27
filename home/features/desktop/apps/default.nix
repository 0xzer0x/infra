{ lib, ... }:

with lib; {
  options.features.desktop.apps.enable =
    mkEnableOption "Enable desktop GUI apps";

  imports = [ ./nixpkgs.nix ./flatpak.nix ];
}
