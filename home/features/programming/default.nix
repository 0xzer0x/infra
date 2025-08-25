{ pkgs, ... }:

{
  home.packages = with pkgs; [
    uv
    go
    gnumake
    cmake
    rustup
    python3Full
    nodejs_24
    devbox
    direnv
    alsa-lib.out
    alsa-lib.dev
  ];
}
