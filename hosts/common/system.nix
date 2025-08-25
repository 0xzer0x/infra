{ pkgs, inputs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

  system.stateVersion = "25.05";

  # WARN: Make sure to have the place the secret key in place before applying the flake
  age.identityPaths = [ "/var/lib/persistent/agenix.key" ];

  environment.systemPackages = with pkgs; [
    # Essentials
    git
    gcc
    vim
    wget
    curl
    nix-ld
    btrfs-progs
    pkg-config
    # Utils
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
  ];

  programs = {
    nix-ld.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
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
