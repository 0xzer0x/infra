{
  config,
  lib,
  pkgs,
  outputs,
  ...
}:

{
  # NOTE: Import custom-defined home-manager modules
  imports = builtins.attrValues outputs.homeManagerModules;

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    overlays =
      let
        homeManagerOverlays = import ../overlays { inherit config; };
      in
      [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.stable-packages
        homeManagerOverlays.additions
      ];
  };

  # NOTE: Sets default XDG directories environment variables
  home.preferXdgDirectories = true;
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Audio";
    };
  };

  # NOTE: Set default shell
  features.cli.shell.default = "fish";
}
