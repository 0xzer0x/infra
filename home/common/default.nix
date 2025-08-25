{ lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  xdg.enable = true;
}
