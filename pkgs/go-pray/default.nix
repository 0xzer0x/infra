{ lib, pkgs, buildGoModule, fetchFromGitHub }:

buildGoModule (finalAttrs: {
  pname = "go-pray";
  version = "0.1.13";

  src = fetchFromGitHub {
    owner = "0xzer0x";
    repo = "go-pray";
    rev = "v${finalAttrs.version}";
    hash = "sha256-wi/sUjzNbVLbqwtM1BglmXgkaqMamjIsGS6EjlyeC9Y=";
  };
  vendorHash = "sha256-qMTg2Vsk0nte1O8sbNWN5CCCpgpWLvcb2RuGMoEngYE=";

  nativeBuildInputs = with pkgs; [ pkg-config alsa-lib.dev ];
  preBuild = ''
    export PKG_CONFIG_PATH=''${PKG_CONFIG_PATH}:${pkgs.alsa-lib.dev.outPath}/lib/pkgconfig
  '';
  ldflags = [
    "-X 'github.com/0xzer0x/go-pray/internal/version.version=${finalAttrs.version}'"
    "-X 'github.com/0xzer0x/go-pray/internal/version.buildCommit=${finalAttrs.version}'"
    "-X 'github.com/0xzer0x/go-pray/internal/version.buildTime=1970-01-01T00:00:00Z'"
  ];

  buildInputs = with pkgs; [ alsa-lib ];

  meta = with lib; {
    description = "Prayer time CLI to remind you to Go pray";
    homepage = "https://github.com/0xzer0x/go-pray";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ _0xzer0x ];
  };
})
