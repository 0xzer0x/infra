{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal
    zsh
    kitty
    tmux
    sesh
    neovim
    # CLI
    file
    bat
    eza
    fzf
    duf
    gum
    fd
    jq
    yq-go
    ripgrep
    fastfetch
    zoxide
    starship
    chezmoi
    lazygit
    kubernetes
    kubecolor
    k9s
    cosign
    htop
    btop
    yazi
    ttyper
    awscli2
    libva-utils
    docker-compose
    lazydocker
    docker-credential-helpers
    dogdns
    lsof
    tealdeer
    go-task
    gopass
    gopass-jsonapi
    git-credential-gopass
    nvtopPackages.intel
    nvtopPackages.amd
    pwgen
    hugo
    terraform
    yt-dlp
    # Programming
    uv
    go
    gnumake
    cmake
    rustup
    python3Full
    nodejs_24
    devbox
    direnv
  ];

  # Libvirt frontend
  programs.virt-manager.enable = true;

  # Virtualization (Docker, Podman, Libvirt)
  virtualisation = {
    docker.enable = true;
    podman.enable = true;

    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        ovmf.enable = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
  };
}
