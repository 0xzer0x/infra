{ pkgs, ... }:

{
  home.packages = [
    pkgs.bc
    (import ./extract-quran-page.nix { inherit pkgs; })
    (import ./audioctl.nix { inherit pkgs; })
    (import ./passgen.nix { inherit pkgs; })
    (import ./vm-init.nix { inherit pkgs; })
  ];
}
