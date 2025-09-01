{ pkgs, ... }:

{
  go-pray = pkgs.callPackage ./go-pray { };
  tmux-nerd-font-window-name =
    pkgs.callPackage ./tmux-plugins/nerd-font-window-name {
      inherit (pkgs.tmuxPlugins) mkTmuxPlugin;
    };
}
