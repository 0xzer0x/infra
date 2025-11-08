{ pkgs, ... }:

{
  tmux-nerd-font-window-name =
    pkgs.callPackage ./tmux-plugins/nerd-font-window-name {
      inherit (pkgs.tmuxPlugins) mkTmuxPlugin;
    };
}
