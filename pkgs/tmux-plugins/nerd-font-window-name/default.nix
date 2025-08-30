{ mkTmuxPlugin, fetchFromGitHub, }:

mkTmuxPlugin rec {
  pluginName = "nerd-font-window-name";
  version = "2.1.2";
  rtpFilePath = "tmux-${pluginName}.tmux";
  src = fetchFromGitHub {
    owner = "joshmedeski";
    repo = "tmux-nerd-font-window-name";
    tag = "v${version}";
    hash = "sha256-bnlOAfdBv5Rg4z1hu1jtdx5oZ6kAZE40K4zqLxmyYQE=";
  };
}

