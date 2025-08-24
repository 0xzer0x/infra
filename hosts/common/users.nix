{ pkgs, ... }:

{
  # Define user accounts.
  users.users = {
    youfathy = {
      description = "Youssef Fathy";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "docker" "podman" "libvirtd" ];
    };
  };

  # Enable password-less sudo for main user
  security.sudo.extraRules = [{
    users = [ "youfathy" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];
}
