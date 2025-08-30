{ lib, buildGoModule, fetchFromGitHub, installShellFiles, pkg-config, alsa-lib,
}:

buildGoModule (finalAttrs: {
  pname = "go-pray";
  version = "0.1.13";

  src = fetchFromGitHub {
    owner = "0xzer0x";
    repo = "go-pray";
    tag = "v${finalAttrs.version}";
    hash = "sha256-wwTAwiO1XONxd6NPXKjzu5B7R211xAgBGPPAvQwOp8I=";
    # NOTE: Required for setting version commit and build time
    leaveDotGit = true;
    postFetch = ''
      cd $out
      git rev-parse HEAD > $out/COMMIT
      date -u -d "@$(git log -1 --pretty=%ct)" "+%Y-%m-%dT%H:%M:%SZ" > $out/SOURCE_DATE_EPOCH
      find "$out" -name .git -print0 | xargs -0 rm -rf
    '';
  };

  vendorHash = "sha256-qMTg2Vsk0nte1O8sbNWN5CCCpgpWLvcb2RuGMoEngYE=";

  nativeBuildInputs = [ pkg-config alsa-lib installShellFiles ];
  ldflags = [
    "-X 'github.com/0xzer0x/go-pray/internal/version.version=${finalAttrs.version}'"
  ];

  preBuild = ''
    ldflags+=" -X github.com/0xzer0x/go-pray/internal/version.buildCommit=$(cat COMMIT)"
    ldflags+=" -X github.com/0xzer0x/go-pray/internal/version.buildTime=$(cat SOURCE_DATE_EPOCH)"
  '';

  buildInputs = [ alsa-lib ];

  postInstall = ''
    # NOTE: Create temporary config file to supress missing config error
    printf 'calculation: { method: "UAQ" }\nlocation: { lat: 0, long: 0 }\n' > tmpconfig.yml
    installShellCompletion --cmd go-pray \
      --bash <($out/bin/go-pray --config=tmpconfig.yml completion bash) \
      --fish <($out/bin/go-pray --config=tmpconfig.yml completion fish) \
      --zsh <($out/bin/go-pray --config=tmpconfig.yml completion zsh)
  '';

  meta = with lib; {
    description = "Prayer times CLI to remind you to Go pray";
    homepage = "https://github.com/0xzer0x/go-pray";
    changelog = "https://github.com/0xzer0x/go-pray/releases/tag/v${version}";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ _0xzer0x ];
    platforms = platforms.linux;
    mainProgram = "go-pray";
  };
})
