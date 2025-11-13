{ config, lib, ... }:

with lib;
let
  cfg = config.features.desktop.apps;
in
{
  options.features.desktop.apps.enable = mkEnableOption "Enable desktop GUI apps";

  imports = [
    ./nixpkgs.nix
    ./flatpak.nix
    ./browser.nix
  ];

  # NOTE: Set default applications
  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "audio/3gpp" = [ "mpv.desktop" ];
        "audio/3gpp2" = [ "mpv.desktop" ];
        "audio/AMR" = [ "mpv.desktop" ];
        "audio/AMR-WB" = [ "mpv.desktop" ];
        "audio/aac" = [ "mpv.desktop" ];
        "audio/ac3" = [ "mpv.desktop" ];
        "audio/basic" = [ "mpv.desktop" ];
        "audio/dv" = [ "mpv.desktop" ];
        "audio/eac3" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "audio/m4a" = [ "mpv.desktop" ];
        "audio/midi" = [ "mpv.desktop" ];
        "audio/mp1" = [ "mpv.desktop" ];
        "audio/mp2" = [ "mpv.desktop" ];
        "audio/mp3" = [ "mpv.desktop" ];
        "audio/mp4" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/mpegurl" = [ "mpv.desktop" ];
        "audio/mpg" = [ "mpv.desktop" ];
        "audio/ogg" = [ "mpv.desktop" ];
        "audio/opus" = [ "mpv.desktop" ];
        "audio/prs.sid" = [ "mpv.desktop" ];
        "audio/scpls" = [ "mpv.desktop" ];
        "audio/vnd.dolby.heaac.1" = [ "mpv.desktop" ];
        "audio/vnd.dolby.heaac.2" = [ "mpv.desktop" ];
        "audio/vnd.dolby.mlp" = [ "mpv.desktop" ];
        "audio/vnd.dts" = [ "mpv.desktop" ];
        "audio/vnd.dts.hd" = [ "mpv.desktop" ];
        "audio/vnd.rn-realaudio" = [ "mpv.desktop" ];
        "audio/vorbis" = [ "mpv.desktop" ];
        "audio/wav" = [ "mpv.desktop" ];
        "audio/webm" = [ "mpv.desktop" ];
        "audio/x-aac" = [ "mpv.desktop" ];
        "audio/x-adpcm" = [ "mpv.desktop" ];
        "audio/x-aiff" = [ "mpv.desktop" ];
        "audio/x-ape" = [ "mpv.desktop" ];
        "audio/x-flac" = [ "mpv.desktop" ];
        "audio/x-gsm" = [ "mpv.desktop" ];
        "audio/x-it" = [ "mpv.desktop" ];
        "audio/x-m4a" = [ "mpv.desktop" ];
        "audio/x-matroska" = [ "mpv.desktop" ];
        "audio/x-mod" = [ "mpv.desktop" ];
        "audio/x-mp1" = [ "mpv.desktop" ];
        "audio/x-mp2" = [ "mpv.desktop" ];
        "audio/x-mp3" = [ "mpv.desktop" ];
        "audio/x-mpeg" = [ "mpv.desktop" ];
        "audio/x-mpegurl" = [ "mpv.desktop" ];
        "audio/x-mpg" = [ "mpv.desktop" ];
        "audio/x-ms-asf" = [ "mpv.desktop" ];
        "audio/x-ms-asx" = [ "mpv.desktop" ];
        "audio/x-ms-wax" = [ "mpv.desktop" ];
        "audio/x-ms-wma" = [ "mpv.desktop" ];
        "audio/x-musepack" = [ "mpv.desktop" ];
        "audio/x-pn-aiff" = [ "mpv.desktop" ];
        "audio/x-pn-au" = [ "mpv.desktop" ];
        "audio/x-pn-realaudio" = [ "mpv.desktop" ];
        "audio/x-pn-realaudio-plugin" = [ "mpv.desktop" ];
        "audio/x-pn-wav" = [ "mpv.desktop" ];
        "audio/x-pn-windows-acm" = [ "mpv.desktop" ];
        "audio/x-real-audio" = [ "mpv.desktop" ];
        "audio/x-realaudio" = [ "mpv.desktop" ];
        "audio/x-s3m" = [ "mpv.desktop" ];
        "audio/x-scpls" = [ "mpv.desktop" ];
        "audio/x-shorten" = [ "mpv.desktop" ];
        "audio/x-speex" = [ "mpv.desktop" ];
        "audio/x-stm" = [ "mpv.desktop" ];
        "audio/x-tta" = [ "mpv.desktop" ];
        "audio/x-vorbis" = [ "mpv.desktop" ];
        "audio/x-vorbis+ogg" = [ "mpv.desktop" ];
        "audio/x-wav" = [ "mpv.desktop" ];
        "audio/x-wavpack" = [ "mpv.desktop" ];
        "audio/x-xm" = [ "mpv.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "image/webp" = [ "imv.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "inode/directory" = [ "nemo.desktop" ];
        "text/html" = [ "app.zen_browser.zen.desktop" ];
        "text/plain" = [ "org.xfce.mousepad.desktop" ];
        "text/x-c++src" = [ "org.xfce.mousepad.desktop" ];
        "video/3gp" = [ "mpv.desktop" ];
        "video/3gpp" = [ "mpv.desktop" ];
        "video/3gpp2" = [ "mpv.desktop" ];
        "video/avi" = [ "mpv.desktop" ];
        "video/divx" = [ "mpv.desktop" ];
        "video/dv" = [ "mpv.desktop" ];
        "video/fli" = [ "mpv.desktop" ];
        "video/flv" = [ "mpv.desktop" ];
        "video/mp2t" = [ "mpv.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/mp4v-es" = [ "mpv.desktop" ];
        "video/mpeg" = [ "mpv.desktop" ];
        "video/mpeg-system" = [ "mpv.desktop" ];
        "video/msvideo" = [ "mpv.desktop" ];
        "video/ogg" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "video/vnd.divx" = [ "mpv.desktop" ];
        "video/vnd.mpegurl" = [ "mpv.desktop" ];
        "video/vnd.rn-realvideo" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/x-anim" = [ "mpv.desktop" ];
        "video/x-avi" = [ "mpv.desktop" ];
        "video/x-flc" = [ "mpv.desktop" ];
        "video/x-fli" = [ "mpv.desktop" ];
        "video/x-flv" = [ "mpv.desktop" ];
        "video/x-m4v" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/x-mpeg" = [ "mpv.desktop" ];
        "video/x-mpeg-system" = [ "mpv.desktop" ];
        "video/x-mpeg2" = [ "mpv.desktop" ];
        "video/x-ms-asf" = [ "mpv.desktop" ];
        "video/x-ms-asf-plugin" = [ "mpv.desktop" ];
        "video/x-ms-asx" = [ "mpv.desktop" ];
        "video/x-ms-wm" = [ "mpv.desktop" ];
        "video/x-ms-wmv" = [ "mpv.desktop" ];
        "video/x-ms-wmx" = [ "mpv.desktop" ];
        "video/x-ms-wvx" = [ "mpv.desktop" ];
        "video/x-msvideo" = [ "mpv.desktop" ];
        "video/x-nsv" = [ "mpv.desktop" ];
        "video/x-ogm" = [ "mpv.desktop" ];
        "video/x-ogm+ogg" = [ "mpv.desktop" ];
        "video/x-theora" = [ "mpv.desktop" ];
        "video/x-theora+ogg" = [ "mpv.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" ];
        "x-scheme-handler/file" = [ "nemo.desktop" ];
        "x-scheme-handler/http" = [ "app.zen_browser.zen.desktop" ];
        "x-scheme-handler/https" = [ "app.zen_browser.zen.desktop" ];
        "x-scheme-handler/obsidian" = [ "obsidian.desktop" ];
        "x-scheme-handler/slack" = [ "slack.desktop" ];
        "x-scheme-handler/discord" = [ "legcord.desktop" ];
        "x-scheme-handler/betterdiscord" = [ "legcord.desktop" ];
        "x-scheme-handler/chrome" = [ "app.zen_browser.zen.desktop" ];
        "application/x-extension-htm" = [ "app.zen_browser.zen.desktop" ];
        "application/x-extension-html" = [ "app.zen_browser.zen.desktop" ];
        "application/x-extension-shtml" = [ "app.zen_browser.zen.desktop" ];
        "application/xhtml+xml" = [ "app.zen_browser.zen.desktop" ];
        "application/x-extension-xhtml" = [ "app.zen_browser.zen.desktop" ];
        "application/x-extension-xht" = [ "app.zen_browser.zen.desktop" ];
        "x-scheme-handler/mailto" = [ "org.mozilla.Thunderbird.desktop" ];
      };
    };
  };
}
