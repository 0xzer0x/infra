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

  # NOTE: Sets default XDG directories environment variables
  xdg.enable = true;
  home.preferXdgDirectories = true;
}
