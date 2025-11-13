{ pkgs, ... }:

{
  imports = [
    ./shell
    ./tmux
    ./scripts
    ./go-pray
    ./env.nix
    ./starship.nix
    ./nvim.nix
    ./fastfetch.nix
    ./gnupg.nix
    ./gopass.nix
    ./ssh.nix
    ./git.nix
    ./k8s.nix
    ./yazi.nix
    ./aws.nix
    ./ansible.nix
    ./containers.nix
    ./virtualization.nix
    ./multimedia.nix
    ./nettools.nix
    ./rss.nix
  ];

  # NOTE: Use programs.<name>.enable whenever possible instead of using home.packages
  programs = {
    fd.enable = true;
    jq.enable = true;
    bat.enable = true;
    fzf.enable = true;
    eza.enable = true;
    htop.enable = true;
    zoxide.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [
    file
    procps
    duf
    gum
    yq-go
    ttyper
    libva-utils
    lsof
    go-task
    pinentry-qt
    pwgen
    openssl
    sshpass
    age
    sops
    nix-output-monitor
    nvd
  ];
}
