{ config, lib, pkgs, inputs, ... }:

with lib;
let cfg = config.customization.users.youfathy;
in {
  sops.secrets."users/youfathy/hashedPassword" =
    mkIf cfg.hashedPasswordFile.enable { neededForUsers = true; };

  users.users.youfathy = let
    passwordAttrSet = (if cfg.hashedPasswordFile.enable then {
      hashedPasswordFile =
        config.sops.secrets."users/youfathy/hashedPassword".path;
    } else {
      initialHashedPassword =
        "$y$j9T$Dn0eeaH0T73fTCJwryaMm1$dq5xw1pKZWZ.uN6S1JMEHS7wpVwfajHUIdDb00NCUgB";
    });
  in {
    shell = pkgs.zsh;
    isNormalUser = true;
    createHome = true;
    description = "Youssef Fathy";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "podman"
      "libvirtd"
      "kvm"
      "input"
      "audio"
      "video"
      "plugdev"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQ6RpkBluDPdk7jMEDIXp1t+FTL402RJQVtGRL322/w youfathy"
    ];
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  } // passwordAttrSet;

  security.sudo.extraRules = [{
    users = [ "youfathy" ];
    commands = [
      # NOTE: Allow elevating privileges (requires password)
      {
        command = "ALL";
      }
      # NOTE: NixOS management
      {
        command = "/run/current-system/sw/bin/nixos-rebuild";
        options = [ "NOPASSWD" ];
      }
      {
        command = "/run/current-system/sw/bin/nix-collect-garbage";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

  home-manager.users.youfathy =
    import ../../../home/youfathy/${config.networking.hostName};
}
