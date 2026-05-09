{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.features.cli.multimedia;
in
{
  options.features.cli.multimedia.enable = mkEnableOption "Enable CLI multimedia utilities";

  config = mkIf cfg.enable {
    programs.yt-dlp.enable = true;

    home.packages = with pkgs; [
      ffmpeg
      libisoburn
      decktape
      gowall
      # WARN: Required for gowall upscale feature
      # Ref: https://achno.github.io/gowall-docs/imageUpscaling/#warning--known-issues
      realesrgan-ncnn-vulkan
    ];

    home.sessionVariables = {
      FFMPEG_DATADIR = "${config.xdg.configHome}/ffmpeg";
    };
  };
}
