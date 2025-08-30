{ pkgs, ... }:

{
  go-pray = pkgs.callPackage ./go-pray { };
  extraTmuxPlugins.nerd-font-window-name =
    pkgs.callPackage ./tmux-plugins/nerd-font-window-name {
      inherit (pkgs.tmuxPlugins) mkTmuxPlugin;
    };
}
