{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.gtk;
in
{
  config = mkIf cfg.enable {
    gtk.gtk3.bookmarks = [
      "file:///mnt/ssd SSD"
      "file:///mnt/ssd/UNI UNI"
      "file:///mnt/ssd/Work Work"
      "file:///mnt/ssd/Work/books Books"
    ];
  };
}
