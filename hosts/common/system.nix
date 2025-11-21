{ pkgs, ... }:

{

  system.stateVersion = "25.05";

  environment.systemPackages = with pkgs; [
    git
    gcc
    vim
    bash
    wget
    curl
    btrfs-progs
    pkg-config
    coreutils-full
    patchelf
    binutils
    gnutar
    zip
    unzip
    unrar
    killall
    duf
    usbutils
    man-db
    man-pages
    man-pages-posix
  ];

  # NOTE: Required for completion of system-wide packages
  environment.pathsToLink = [ "/share/zsh" ];

  programs = {
    nix-ld.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };

    fish = {
      enable = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 15d";
      };
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
