{ pkgs, ... }:

{
  home.packages = [ pkgs.bc (import ./brightness.nix { inherit pkgs; }) ];
}
