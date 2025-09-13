{ inputs, outputs, lib, ... }:

{
  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@wheel" ];
      use-xdg-base-directories = true;
      auto-optimise-store = true;
      min-free = 32212254720;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };

    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = [ "/etc/nix/path" ]
      ++ lib.mapAttrsToList (flakeName: _: "${flakeName}=flake:${flakeName}")
      flakeInputs;
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
  };
}
