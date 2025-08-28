{ config, pkgs, inputs, ... }:

{
  users.users.youfathy = {
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
  };

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
    import ../../../home/youfathy/${config.networking.hostName}.nix;
}
