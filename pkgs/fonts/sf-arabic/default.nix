{ lib, stdenv, fetchurl, p7zip, ... }:

stdenv.mkDerivation {
  pname = "sf-arabic-font";
  version = "1.0";

  src = fetchurl {
    url =
      "https://devimages-cdn.apple.com/design/resources/download/SF-Arabic.dmg";
    hash = "sha256-J2DGLVArdwEsSVF8LqOS7C1MZH/gYJhckn30jRBRl7k=";
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
      "A contemporary interpretation of the Naskh style with a rational and flexible design.";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
  };
}
