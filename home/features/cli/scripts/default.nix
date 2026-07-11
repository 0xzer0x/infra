{ lib, pkgs, ... }:

{
  home.packages = [
    pkgs.bc
    (import ./audioctl.nix { inherit pkgs; })
    (import ./passgen.nix { inherit pkgs; })
    (import ./vm-init.nix { inherit pkgs; })
    (import ./warper.nix { inherit lib pkgs; })
  ];
}
