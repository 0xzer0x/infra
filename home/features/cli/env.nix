{ config, ... }:

{
  home.sessionVariables = {
    NIXOS_SYSTEM_FLAKE = "${config.xdg.configHome}/infra";
    LESSKEY = "${config.xdg.configHome}/less/lesskey";
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    VIMDOTDIR = "${config.xdg.configHome}/vim";
    KDEHOME = "${config.xdg.configHome}/kde";
  };

  # NOTE: Directories to add to PATH
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.local/usr/bin"
  ];
}
