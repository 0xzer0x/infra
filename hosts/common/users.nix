{ pkgs, ... }:

{
  # Define user accounts.
  users.users = {
    youfathy = {
      shell = pkgs.zsh;
      isNormalUser = true;
      createHome = true;
      description = "Youssef Fathy";
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
