{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.multimedia;
in {
  options.features.cli.multimedia.enable =
    mkEnableOption "Enable CLI multimedia utilities";

  config = mkIf cfg.enable {
    programs.yt-dlp.enable = true;
    home.packages = with pkgs; [ grim slurp ffmpeg libisoburn ];
    home.sessionVariables = {
      FFMPEG_DATADIR = "${config.xdg.configHome}/ffmpeg";
    };
  };
}
