{ lib, stdenv, fetchurl, p7zip, ... }:

stdenv.mkDerivation {
  pname = "sf-pro-font";
  version = "1.0";

  src = fetchurl {
    url =
      "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    hash = "sha256-Lk14U5iLc03BrzO5IdjUwORADqwxKSSg6rS3OlH9aa4=";
  };

  nativeBuildInputs = [ p7zip ];
  unpackCmd = ''
    7z x $curSrc
    find . -name "*.pkg" -print -exec 7z x {} \;
    find . -name "Payload~" -print -exec 7z x {} \;
  '';
  sourceRoot = "./Library/Fonts";

  dontBuild = true;

  installPhase = ''
    find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
    find . -name '*.otf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
  '';

  meta = {
    homepage = "https://developer.apple.com/fonts/";
    description =
      "SF Pro features nine weights, variable optical sizes for optimal legibility, four widths, and includes a rounded variant. SF Pro supports over 150 languages across Latin, Greek, and Cyrillic scripts.";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
  };
}
