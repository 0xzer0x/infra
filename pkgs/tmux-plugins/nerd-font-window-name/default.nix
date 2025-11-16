{ mkTmuxPlugin, fetchFromGitHub }:

mkTmuxPlugin rec {
  pluginName = "nerd-font-window-name";
  version = "2.2.0";
  rtpFilePath = "tmux-${pluginName}.tmux";
  src = fetchFromGitHub {
    owner = "joshmedeski";
    repo = "tmux-nerd-font-window-name";
    tag = "v${version}";
    hash = "sha256-WIwGVk3j2QMXo5Q65ByY4nj8ySUVcpwptAAjw6kh8ds=";
  };
}
